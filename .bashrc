# Always use vim
EDITOR=vim
GIT_EDITOR=vim

# Add things to path
export PATH=$PATH:/sbin:/usr/sbin:~/local/bin
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

PROMPT_COMMAND='PS1="$(display_last_return_status) $PS1_GIT"'

# Hub
if (type hub &> /dev/null); then
  alias git=hub
fi

# Funsies
if (type cowsay &> /dev/null) && (type fortune &> /dev/null); then
  cowsay -f stegosaurus $(fortune -a)
fi

# I use this for things and stuff
function make_a_hash {
  date +'%F %T %N' | md5sum | sed 's/^\([0-9a-f]\+\) \+-.*$/\1/' | tee >(pbcopy)
}
