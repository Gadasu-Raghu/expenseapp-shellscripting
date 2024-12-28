echo this is backend application
source common.sh
component=backend

echo install NodeJS Repos
dnf module disable nodejs -y  &>> $log_file
dnf module enable nodejs:18 -y &>> $log_file
dnf install nodejs -y &>> $log_file

echo Copy Backend Service File
#keeping this copy command before changing directory in this sequence
cp backend.service /etc/systemd/system/backend.service &>> $log_file

echo Add Application user
id expense &>> $log_file
if [ $? -ne 0 ]; then    # echo $? = 0 then user is there so, not equel to 0 then add
  useradd expense &>> $log_file
fi

stat_check

echo Clean App conetnt
rm -rf /app &>> $log_file
mkdir /app &>> $log_file
stat_check

cd /app  &>> $log_file

download_and_extract
stat_check

cd /app  &>> $log_file
echo download Dependencies
npm install &>> $log_file
stat_check

echo  Start backend service demon-reload
systemctl daemon-reload &>> $log_file
systemctl enable backend &>> $log_file
systemctl start backend &>> $log_file
stat_check

echo install MYSQL client
dnf install mysql -y &>> $log_file
stat_check

echo load schema
mysql -h mysqldb.olgatechnologies.cloud -uroot -pExpenseApp@1 < /app/schema/backend.sql &>> $log_file
stat_check
