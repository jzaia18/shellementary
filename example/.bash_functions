#!/bin/bash

# creates folder with today's date
today() {
    # When you surround a command like so
    # $(COMMAND_LINE_UTILITY)
    # bash returns the output of the command
    # So the following sets the variable date
    # to the current date in the format
    # year-month-day
    date=$(date '+%Y-%m-%d')
    # -d: does the directory exit
    if [ -d $date ]; then
        echo "Already Exists"
    else
        mkdir $date
    fi
    cd $today
}

# logging function for devlogs
log() {
    # -z: does the string exist
    if [ -z "$1" ]; then
        echo -e "error: no arguments supplied\nusage: log <message>"
        return 1
    fi
    # get the date in the proper format for devlogs
    date=$(date '+%Y-%m-%d %H:%M:%S')
    # append name, date, and devlog messsage to the devlog file
    echo -e "lastF -- $date\n$1\n" >> devlog.txt
}

# redefine cd to also do ls
cd () {
    # bash keyword builtin ensure the original cd is used
    builtin cd "$1" && ls || return
    # piping into return ensures that the function
    # still return the proper error code
}

# make folder if necessary and cd into it
mkcd() {
    mkdir -p "$1"
    cd "$1"
}

# Create basic Flask structure
createFlask() {
    # -z: does the string exist
    if [ -z "$1" ]; then
        echo -e "error: no arguments supplied\nusage: createFlask <filename>"
        return 1
    fi
    touch $1.py
    mkdir -p templates;
    touch templates/base.html;
    mkdir -p static;
    mkdir -p utils;
    touch utils/__init__.py;
    mkdir -p data;
}

# returns a random file in the current directory
randfile() {
    find -mindepth 1 -maxdepth 1 -type f | shuf -n 1
}

# returns a random directory in the current directory
randdir() {
    find -mindepth 1 -maxdepth 1 -type d | shuf -n 1
}
# an example use case might be
# cd $(randdir)
# to cd into a random directory

# pull all git repositories in current directory to at max 5 directories deep
gpa () {
    find -maxdepth 5 -name .git -type d -execdir echo -n "Pulling: " \; -execdir pwd \; -execdir git pull \;;
}
