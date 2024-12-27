#here created a variable log_file and calling it whereever it needed as a variable

log_file=/tmp/expense.log

echo installing nginx
dnf install nginx -y >> $log_file

echo copying the expese.conf to default.d
cp expense.conf /etc/nginx/default.d/expense.conf >> $log_file

echo removing the old nginx web content
rm -rf /usr/share/nginx/html/* >> $log_file

echo download frontend code
curl -s -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >> $log_file

cd /usr/share/nginx/html

echo extracting frontend code
unzip /tmp/frontend.zip >> $log_file

echo starting nginx service
systemctl enable nginx >> $log_file
systemctl restart nginx >> $log_file