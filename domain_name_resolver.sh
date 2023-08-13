#!/bin/bash
file_path="domain_names.txt"

while IFS= read -r domain_name; do
    domain_name=$(echo "$domain_name" | tr -d '[:space:]')
    first_char="${domain_name%"${domain_name#?}"}"
    if [ "$first_char" != "#" ]; then
        result=$(dig "$domain_name" @1.1.1.1 | grep ";; ANSWER SECTION:")
        if [ -z "$result" ]; then
            output="No Results"
        else
            output=$(dig "$domain_name" @1.1.1.1 | awk '/;; ANSWER SECTION:/ { flag=1; next } flag { if (NF == 0) exit; print $4, $5 }')
            # echo "$output"
        fi
        printf "%-25s %-30s %s\n" "$domain_name" "$output"
    fi
done < "$file_path"
