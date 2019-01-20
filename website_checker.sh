#!/bin/bash

url_target="https://www.$1"
working_dir="/YOUR/WORKING/DIR"
LOG_TIMESTAMP="[$(date +"%Y-%m-%d %H:%M:%S,%3N")]"

curl --silent -A "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:15.0) Gecko/20100101 Firefox/15.0.1" -IXGET "${url_target}" --http2 -o $working_dir/temporary.txt

line=$(head -n 1 $working_dir/temporary.txt)
temporary_result=${line:7:3}

if [[ $temporary_result == *"200"* ]]
then
        output_message=" $1 - Good response"
else
        curl --silent -A "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:15.0) Gecko/20100101 Firefox/15.0.1" -IXGET "https://www.google.com" --http2 -o $working_dir/temp2.txt
        line2=$(head -n 1 $working_dir/temp2.txt)
        goog_check=${line2:7:3}
        rm -f $working_dir/temp2.txt
        if [[ $goog_check == *"200"* ]]
        then
                goog_output="(Google check success)"
        else
                goog_output="(Google check failure - This device's internet connection may be down)"
        fi
        output_message=" $1 - Bad response - $goog_output"
fi

touch $working_dir/$1.log

echo $LOG_TIMESTAMP $output_message >> $working_dir/$1.log

MaxFileSize=40960
#Get size in bytes**
file_size=`du -b $working_dir/$1.log | tr -s '\t' ' ' | cut -d' ' -f1`
if [ $file_size -gt $MaxFileSize ];then
        timestamp=`date +%s`
        mv $working_dir/test.log $working_dir/$1.log.$timestamp
        touch $working_dir/test.log
fi

rm -f $working_dir/temporary.txt
