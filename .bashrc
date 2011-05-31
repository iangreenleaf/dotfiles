# Always use vim
EDITOR=vim
GIT_EDITOR=vim

# Add things to path
PATH=$PATH:/sbin:/usr/sbin:~/local/bin
PATH=./script:$PATH

# Don't put duplicate lines in history
export HISTCONTROL=ignoredups
# Bigger history
HISTSIZE=5000

# Make my searches case-insensitive
PAGER=/usr/bin/less\ -i
export PAGER

# Color output
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# Trash from the CLI
alias trash="trash-put"

# Common searching aliases
alias hgrep="history | grep"
alias pgrep="ps aux | grep"

alias log='tail -f -n 100'

# Show the current git branch in the prompt
function git_current_branch { git branch 2>/dev/null | grep '^*' | cut -f2- -d' '; }
PROMPT_COMMAND=$PROMPT_COMMAND${PROMPT_COMMAND:+;}'PS1="\[\e[01m\]\t\[\e[0m\] \[\e[1;32m\]`git_current_branch` \[\e[0m\]\[\e[33m\]\w \[\e[0m\]\[\e[1m\]\$\[\e[0m\] "'
