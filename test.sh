#!/bin/bash
echo "$PIN_HOME"
while IFS=$'\n$' read -r LINE; do
 cp $LINE . 
# IFS=, read -r a b;
done < files.txt
