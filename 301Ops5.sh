#!/bin/bash

# Script Name:                  Ops Challenge: Clearing Logs
# Author:                       Juan Miguel Cano
# Date of latest revision:      12/01/2023
# Purpose:                      Create a fake log, compresses it, clears its contents, 
# cont:                         and prints info on the compression process.
# Execution:                    bash 301Ops5.sh
# Resources:                    https://chat.openai.com/share/228c9805-5636-480b-a4cc-fb417f69a0a2



touch "my-log-file.txt"
echo "Pinto Bean for Dogs generated by Juan ... " >> my-log-file.txt
cat my-log-file.txt
mkdir -p "backups"  
LOG_FILES=("my-log-file.txt")  
BACKUP_DIR="backups"  
TIMESTAMP=$(date +"%m%d%Y")  

for file in "${LOG_FILES[@]}"; do
    FILE_NAME=$(basename "$file" .txt)
    FILE_SIZE=$(wc -c "$file" | awk '{print $1}')
    zip -r "$BACKUP_DIR/$FILE_NAME-$TIMESTAMP.zip" "$file"
    cat /dev/null > "$file"
    COMPRESSED_FILE_SIZE=$(wc -c "$BACKUP_DIR/$FILE_NAME-$TIMESTAMP.zip" | awk '{print $1}')

    echo "File size before compression: $FILE_SIZE"
    echo "File size after compression: $COMPRESSED_FILE_SIZE"

    if [[ $FILE_SIZE -gt $COMPRESSED_FILE_SIZE ]]; then
        echo "Compression successful: compressed file size is smaller than original file size"
    else
        echo "Compression unsuccessful: compressed file size is larger than original file size"
    fi
done