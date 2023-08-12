#!/bin/bash
file_path="domain_names.txt"

while IFS= read -r domain_name; do
    if [ "${domain_name:0:1}" != "#" ]; then
        dig "$domain_name" @1.1.1.1 | grep ";; ANSWER SECTION:"
    fi
done < "$file_path"