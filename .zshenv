# Always use vim
EDITOR=vim
GIT_EDITOR=vim

# Add things to path
export PATH=$PATH:/sbin:/usr/sbin:~/bin:~/local/bin
export PATH=./node_modules/.bin:$PATH
export PATH=./bin:$PATH

# Persist history in Erlang/Elixir shell
export ERL_AFLAGS="-kernel shell_history enabled"
