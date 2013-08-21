if [ -f ~/dotfiles/.vimrc ]; then
  if [ -z "${VIM_COMMAND}" ]; then
    VIM_COMMAND=vim
  fi
  alias vim="${VIM_COMMAND} -u ~/dotfiles/.vimrc"
  alias vimrc="vim ~/dotfiles/.vimrc"
fi
