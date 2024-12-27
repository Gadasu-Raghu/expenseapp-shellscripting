#here created a variable log_file and calling it whereever it needed as a variable
echo this is frontend application
source common.sh
component=frontend

echo installing nginx
dnf install nginx -y &>> $log_file
echo $?

echo copying the expese.conf to default.d
cp expense.conf /etc/nginx/default.d/expense.conf &>> $log_file
echo $?

echo removing the old nginx web content
rm -rf /usr/share/nginx/html/* &>> $log_file
echo $?

cd /usr/share/nginx/html

download_and_extract
echo $?

echo starting nginx service
systemctl enable nginx &>> $log_file
systemctl restart nginx &>> $log_file
echo $?