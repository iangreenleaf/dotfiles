# Always use vim
EDITOR=vim
GIT_EDITOR=vim

# Add things to path
export PATH=$PATH:/sbin:/usr/sbin:~/bin:~/local/bin
export PATH=./node_modules/.bin:$PATH
export PATH=./script:./bin:$PATH

# Don't put duplicate lines in history
export HISTCONTROL=erasedups
# Bigger history
export HISTSIZE=100000

# Make my searches case-insensitive
PAGER=less\ -i
export PAGER

# Color output
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Trash from the CLI
alias trash="trash-put"

# Common searching aliases
alias hgrep="history | grep"
alias pgrep="ps aux | grep"

# Show the current git branch in the prompt
function git_current_branch { git branch 2>/dev/null | grep '^*' | cut -f2- -d' '; }
PS1_GIT='\[\e[01m\]\t\[\e[0m\] \[\e[1;32m\]`git_current_branch` \[\e[0m\]\[\e[33m\]\w \[\e[0m\]\[\e[1m\]\$\[\e[0m\] '

# Show return status in the prompt
function display_last_return_status { if [ $? = 0 ]; then echo "\[\e[0;32m\]★\[\e[0m\]"; else echo '\[\e[0;31m\]⚠\[\e[0m\]'; fi }

function terminal_title { echo -ne "\033]0;$(basename "`pwd`"):$(git_current_branch)($(ls -a | wc -l))\007"; }

PROMPT_COMMAND='PS1="$(display_last_return_status)$PS1_GIT"; terminal_title'

# Append to history, don't overwrite
shopt -s histappend
# Sync bash history every so often
PROMPT_COMMAND="$PROMPT_COMMAND; history_sync"
HISTORY_SYNC_EVERY_X_COMMANDS=100
function history_sync {
  history_sync_in=$(($history_sync_in-1));
  if [ $history_sync_in -lt 1 ]; then
    history -a
    history_sync_in=$HISTORY_SYNC_EVERY_X_COMMANDS
  fi
}

# Hub
if (type hub &> /dev/null); then
  alias git="hub"
fi

# Funsies
if (type cowsay &> /dev/null) && (type fortune &> /dev/null); then
  cowsay -f stegosaurus $(fortune -a)
fi

# I use this for things and stuff
function make_a_hash {
  date +'%F %T %N' | md5sum | sed 's/^\([0-9a-f]\+\) \+-.*$/\1/' | tee >(xclip -i -selection clipboard)
}

# boom autocompletion
_boom_complete() {
    local cur prev lists curr_list items
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    curr_list=`eval echo "$prev"`
    local IFS=$'\n'

    if [ $COMP_CWORD -eq 1 ]; then
        lists=`boom | sed 's/^  \(.*\) ([0-9]\+)$/\1/'`
        COMPREPLY=( $( compgen -W '${lists}' -- ${cur} ) )
    elif [ $COMP_CWORD -eq 2 ]; then
        items=`boom $curr_list | sed 's/^    \(.\{0,16\}\):.*$/\1/'`
        COMPREPLY=( $( compgen -W '${items}' -- ${cur} ) )
    fi
}
complete -o filenames -F _boom_complete boom

# Disable global menu in Ubuntu
# Otherwise it throws around warnings when I use XFCE
UBUNTU_MENUPROXY=
