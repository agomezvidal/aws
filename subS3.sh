#! /bin/bash

FILES=$1

echo "This is the loop for $1 file"
while IFS= read -r line

  do
   echo ${line:20}
   aws s3api get-bucket-tagging --bucket ${line:20} 
done < "$FILES"
