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

alias trash="trash-put"

alias hgrep="history | grep"
alias pgrep="ps aux | grep"
