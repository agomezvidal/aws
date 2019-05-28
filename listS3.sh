#!/bin/bash

LIST="accounts.txt"

echo "start processing account $LIST file"

while IFS= read -r line
do
  #echo "aws s3 ls --profile $line  > ${line}S3list.txt"
  aws s3 ls --profile $line > ${line}S3list.txt
  if [ -s ${line}S3list.txt ]
    then
      #echo "./subS3.sh ${line}S3list.txt"
      ./subS3.sh ${line}S3list.txt > ${line}_subS3.output 2>&1
    else
      echo "This is the loop for ${line}S3list.txt file but has no S3 buckets"
   fi
cat ${line}_subS3.output | grep -B2 "TagSet does not exist"
done < "$LIST"
exit $?
