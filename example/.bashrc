#!/bin/bash

# Test for an interactive shell.
if [[ $- != *i* ]] ; then
    return
fi

# Use bash completion if available
[[ -f /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion
[[ -e /etc/bash/bashrc.d/bash_completion.sh ]] && source /etc/bash/bashrc.d/bash_completion.sh

shopt -s autocd                                 # Name of directory executed as if it was argument to `cd`
shopt -s cdspell                                # Check and correct slight spelling errors
shopt -s checkjobs                              # List status of jobs before exiting
shopt -s checkwinsize                           # Check the window size after every command
shopt -s cmdhist                                # Save all lines of multi-line command to same history entry
shopt -s dirspell                               # Check and correct slight spelling errors
shopt -s dotglob                                # Include files starting with `.` in pathname expansion
shopt -s extglob                                # Extended pattern matching features
shopt -s globstar                               # `**` matches all files and directories/subdirectories
shopt -s histappend                             # Append to history file instead of overwriting
shopt -s no_empty_cmd_completion                # Do not search for completions if line is empty

# Prompt Command
# The Prompt Command is run everytime you press enter
# Therefore, it is primarily used to modify the shell prompt
# But it doesn't have to be

# Non Prompt Updating Example
PROMPT_COMMAND=date
# In this scenario the date command line utility would be executed after
# every command

# Actual Prompt Updating Example
PROMPT_COMMAND=_prompt
_prompt() {

    local EXIT="$?"     # Save exit code of last run command; this must be first
    PS1=''              # Reset prompt

    # Basic colors and formatting
    local RED="\[$(tput setaf 1)\]"
    local GREEN="\[$(tput setaf 2)\]"
    local YELLOW="\[$(tput setaf 3)\]"
    local BLUE="\[$(tput setaf 4)\]"
    local MAGENTA="\[$(tput setaf 5)\]"
    local CYAN="\[$(tput setaf 6)\]"
    local RESET="\[$(tput sgr0)\]"
    local BOLD="\[$(tput bold)\]"

    # Show exit code if not 0
    if [[ $EXIT != 0 ]]; then
        PS1+="${RED}$EXIT "
    fi

    # User and hostname
    PS1+="${BOLD}"
    PS1+="${YELLOW}\u"    # \u represent the current user
    PS1+="${MAGENTA}@"
    PS1+="${BLUE}\h"      # \h represents the hostname

    PS1+="${GREEN} \w"    # Current working directory
    PS1+="${RESET} \$ "   # actual prompt

}

# Sourcing Individual Files

for file in ~/.bash_{aliases,exports,functions}; do
    # -r: is the input readable
    # -f: does the file exist
    if [ -r "$file" ] && [ -f "$file" ]; then
        source "$file"
    fi
done

# As you can see, the above for loop has some weird braces
# In bash there is a thing called brace expansion
# The example above: ~/.bash_{aliases,exports,functions}
# creates the following list
# [~/.bash_aliases, ~/.bash_exports, ~/.bash_functions]
# However you aren't limited to strings
# You can also use characters and numbers
# For example
# {a..z}: returns all the characters from a to z
# {0..100}: returns all the integers from 0 to 100
