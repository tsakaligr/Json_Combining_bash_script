#!/bin/bash

# This script combines .json files
#
# Input [1]: directory with .json files
# Output: json file in the stdout 

declare directory="${1}"

declare -a files=()
readarray -d '' files < <(find "${directory}" -type f -print0 | sort -z | xargs -0 -I % echo % | grep -E '^*.\.json$' | xargs -I % echo -ne '%\0')

# In a given file '[' can be inserted with: sed '1i \['
echo "["

for f in "${files[@]:0:${#files[@]}-1}"; do
	cat "${f}" | sed '$s/$/,/'
done

if [ "${#files[@]}" -gt 0 ]; then
	cat "${files[-1]}" | sed '$s/$//'
fi

# In a given file ']' can be inserted with: sed '$a \]'
echo "]"

exit 0
