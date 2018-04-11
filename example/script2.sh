#! /bin/bash
# Name_file creator
echo "What is your name?"
read NAME
echo "Creating a file with your name..."
touch "${NAME}_file.txt"
