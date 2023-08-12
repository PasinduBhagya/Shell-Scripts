#!/bin/bash
file_path="domain_names.txt"

while IFS= read -r domain_name; do
    first_char="${domain_name%"${domain_name#?}"}"
    if [ "$first_char" != "#" ]; then
        result=$(dig "$domain_name" @1.1.1.1 | grep ";; ANSWER SECTION:")
        if [ -z "$result" ]; then
            output="No Results"
        else
            output="Results"
        fi
    fi
    echo "$domain_name"
done < "$file_path"

#Hello