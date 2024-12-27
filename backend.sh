echo this is backend application
source common.sh
component=backend

echo install NodeJS Repos
dnf module disable nodejs -y  >> $log_file
dnf module enable nodejs:18 -y >> $log_file
dnf install nodejs -y >> $log_file

echo Copy Backend Service File
#keeping this copy command before changing directory in this sequence
cp backend.service /etc/systemd/system/backend.service >> $log_file

echo Add Application user
useradd expense >> $log_file

echo Clean App conetnt
rm -rf /app >> $log_file
mkdir /app >> $log_file

cd /app  >> $log_file

download_and_extract

cd /app  >> $log_file
echo download Dependencies
npm install >> $log_file

echo  Start backend service demon-reload
systemctl daemon-reload >> $log_file
systemctl enable backend >> $log_file
systemctl start backend >> $log_file

echo install MYSQL client
dnf install mysql -y >> $log_file

echo load schema
mysql -h mysqldb.olgatechnologies.cloud -uroot -pExpenseApp@1 < /app/schema/backend.sql >> $log_file

