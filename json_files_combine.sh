#!/bin/bash

# This script combines .json files
#
# Input [1]: directory with .json files
# Output: json file in the stdout 

declare directory="${1}"

seperate_json_entries() {
        local -n file_list="${1}"

        for f in "${file_list[@]:0:${#file_list[@]}-1}"; do
                cat "${f}" | sed '$s/$/,/'
        done

        if [ "${#file_list[@]}" -gt 0 ]; then
                cat "${file_list[-1]}" | sed '$s/$//'
        fi
}

declare -a files=()
readarray -d '' files < <(ls "${directory}" | sort -z | xargs -0 -I % echo % | grep -E '^*.\.json$' | xargs -I % echo "${directory%/}/%" | xargs -I % echo -ne '%\0')

# In a given file '[' can be inserted with: sed '1i \['
echo "["

seperate_json_entries 'files'

# In a given file ']' can be inserted with: sed '$a \]'
echo "]"

exit 0
