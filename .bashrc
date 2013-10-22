# alias
alias ls='ls -G'
alias ll='ls -l'

# pbcopy,pbpaste (osx)
if which pbcopy > /dev/null 2>&1; then
  alias pb='pbcopy|pbpaste'
fi

# vimrc
if [ -f ~/dotfiles/.vimrc ]; then
  if [ -z "${VIM_COMMAND}" ]; then
    VIM_COMMAND=vim
  fi
  alias vim="${VIM_COMMAND} -u ~/dotfiles/.vimrc"
  alias vimrc="vim ~/dotfiles/.vimrc"
fi
