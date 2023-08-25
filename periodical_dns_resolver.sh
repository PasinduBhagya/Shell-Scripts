#!/bin/bash

expected_results="13.229.175.58"
domain_name="nibm.lk"
matched_count=0
unmatched_count=0
count_down=1

function scanning() {
    
echo "Sending DNS Request...."
result=$(dig "$domain_name" @1.1.1.1 | grep ";; ANSWER SECTION:")

if [ -z "$result" ]; then
    output="No Results"
else
    output=$(dig "$domain_name" @1.1.1.1 | awk '/;; ANSWER SECTION:/ { flag=1; next } flag { if (NF == 0) exit; print $5 }')
    if [ $output == $expected_results ]; then
        matched_count=$((matched_count+1))
    else
        unmatched_count=$((unmatched_count+1))
    fi

fi
}
while [ "$count_down" -le 60 ]; do
    echo "---------------------------------"
    echo "Scanning Phase $count_down"
    scanning 
    echo "Sleeping for 5 Seconds....."
    sleep 5
    ((count_down++))
done

echo "---------------------------------"
echo "Matched - $matched_count"
echo "Not Matached - $unmatched_count"
