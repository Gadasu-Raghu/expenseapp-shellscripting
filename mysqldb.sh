echo this is mysqlDB application
source common.sh

echo Disable mysql default version
dnf module disable mysql -y &>>$log_file
echo $?

echo Copy Mysql repo file
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>$log_file
echo $?

echo install mysql server
dnf install mysql-community-server -y &>>$log_file
echo $?

echo start mysql service
systemctl enable mysqld &>>$log_file
systemctl start mysqld &>>$log_file
echo $?

echo setup root password
mysql_secure_installation --set-root-pass ExpenseApp@1  &>>$log_file
mysql -uroot -p ExpenseApp@1 &>>$log_file
echo $?