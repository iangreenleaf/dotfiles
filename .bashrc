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
function git_dirty_colors {
  if [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]]; then color='31'; else color='32'; fi
  echo -n '\[\e[01m\]\t\[\e[0m\] \[\e[1;' "$color" 'm\]`'
  echo -n $1
  echo -n '` \[\e[0m\]\[\e[33m\]\w \[\e[0m\]\[\e[1m\]\$\[\e[0m\] '
}
PS1_GIT="`git_dirty_colors git_current_branch`"

# Show return status in the prompt
function display_last_return_status { if [ $? = 0 ]; then echo "\[\e[0;32m\]★\[\e[0m\]"; else echo '\[\e[0;31m\]⚠\[\e[0m\]'; fi }

PROMPT_COMMAND='PS1="$(display_last_return_status)$PS1_GIT"'

# Funsies
if (type cowsay &> /dev/null) && (type fortune &> /dev/null); then
  cowsay -f stegosaurus $(fortune -a)
fi

# I use this for things and stuff
function make_a_hash {
  date +'%F %T %N' | md5sum | sed 's/^\([0-9a-f]\+\) \+-.*$/\1/' | tee >(xclip -i -selection clipboard)
}
