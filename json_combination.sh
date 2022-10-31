#! /bin/bash

#this script combines .json files
#takes as input the first the the last .json file of the folder
#it makes a .json file called all.json as an output

echo "," | tee -a *.json
sed -i '$ s/.$/ /' $2
echo "]" | tee -a $2
sed -i '1s/^/[\n/' $1
cat *.json > all.json
