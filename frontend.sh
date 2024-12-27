echo installing nginx
dnf install nginx -y >> /tmp/expense.log

echo copying the expese.conf to default.d
cp expense.conf /etc/nginx/default.d/expense.conf >> /tmp/expense.log

echo removing the old nginx web content
rm -rf /usr/share/nginx/html/* >> /tmp/expense.log

echo download frontend code
curl -s -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/frontend.zip >> /tmp/expense.log

cd /usr/share/nginx/html

echo extracting frontend code
unzip /tmp/frontend.zip >> /tmp/expense.log

echo starting nginx service
systemctl enable nginx >> /tmp/expense.log
systemctl restart nginx >> /tmp/expense.log