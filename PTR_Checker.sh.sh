#!/bin/bash

filename="IP_ADDRESS.txt"

while read -r IP_Address
do
    dig -x $IP_Address | grep -A1 ";; ANSWER SECTION:" | tail -1

done < $filename

# for IP_Address in "${IP_Address_List[@]}"
# do
#   
# done

