log_file=/tmp/expense.log

download_and_extract(){
  echo download $component code
  curl -s -o /tmp/$component.zip https://expense-artifacts.s3.amazonaws.com/$component.zip >> $log_file
  stat_check

  echo extracting $component code
  unzip /tmp/$component.zip >> $log_file
  stat_check
}

stat_check() {
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"  # Green text for success
  else
    echo -e "\e[31mFAILURE\e[0m"  # Red text for failure
    exit 1
  fi
}