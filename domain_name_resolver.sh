#!/bin/bash
file_path="domain_names.txt"

while IFS= read -r domain_name; do
    domain_name=$(echo "$domain_name" | tr -d '[:space:]')
    domain_name="dns.google.com"
    first_char="${domain_name%"${domain_name#?}"}"
    if [ "$first_char" != "#" ]; then
        printf "%-25s" "$domain_name"

        result=$(dig "$domain_name" @1.1.1.1 | grep ";; ANSWER SECTION:")
        
        if [ -z "$result" ]; then
            output="No Results"
        else
            output=$(dig "$domain_name" @1.1.1.1 | awk '/;; ANSWER SECTION:/ { flag=1; next } flag { if (NF == 0) exit; print $4, $5 }')
            line_count=$(echo "$output" | wc -l)
        fi

        count=1
        while [ $count -lt $line_count ]; do
            printf "%-25s" "$output"
            ((count++))
        done
        
    fi
done < "$file_path"
