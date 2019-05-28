#!/bin/bash

LIST="accounts.txt"

echo "start processing account $LIST"

while IFS= read -r line
do
  #echo "aws s3 ls --profile $line  > ${line}S3list.txt"
  aws s3 ls --profile $line > ${line}S3list.txt
  if [ -s ${line}S3list.txt ] 
    then
      #echo "./subS3.sh ${line}S3list.txt"
      ./subS3.sh ${line}S3list.txt > ${line}_subS3.output 2>&1
    else
      echo "${line}S3list.txt empty"
   fi
cat ${line}_subS3.output | grep -B3 "error"
done < "$LIST"
