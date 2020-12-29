#
# To be sourced by ~/.zshrc, which probably has oh-my-zsh config
#

# Common searching aliases
alias hgrep="history | grep"
alias pgrep="ps aux | grep"

# Use ag to filter files when present
if (type ag &> /dev/null); then
  export FZF_DEFAULT_COMMAND='ag -l --nocolor --hidden -g "" --ignore=.git'
fi

# Default `open` command
if (type exo-open &> /dev/null); then
  alias open="exo-open"
elif (type xdg-open &> /dev/null); then
  alias open="xdg-open"
fi

if (type hub &> /dev/null); then
  eval "$(hub alias -s)"
fi

# I use this for things and stuff
function make_a_hash {
  date +'%F %T %N' | md5sum | sed 's/^\([0-9a-f]\+\) \+-.*$/\1/' | tee >(xclip -i -selection clipboard)
}
