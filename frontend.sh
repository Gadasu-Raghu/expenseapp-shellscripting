#here created a variable log_file and calling it whereever it needed as a variable
echo this is frontend application
source common.sh
component=frontend

echo installing nginx
dnf install nginx -y &>> $log_file

if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi


echo copying the expese.conf to default.d
cp expense.conf /etc/nginx/default.d/expense.conf &>> $log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

echo removing the old nginx web content
rm -rf /usr/share/nginx/html/* &>> $log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

cd /usr/share/nginx/html

download_and_extract
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi

echo starting nginx service
systemctl enable nginx &>> $log_file
systemctl restart nginx &>> $log_file
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
fi