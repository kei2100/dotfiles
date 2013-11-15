# alias
alias ls='ls -G'
alias ll='ls -l'

# (osx setting)
## pbcopy,pbpaste (osx)
if which pbcopy > /dev/null 2>&1; then
  alias pb='perl -pe "chomp" | pbcopy && pbpaste'
fi
## Open UNC path by converting to samba path
if which unc2smb > /dev/null 2>&1; then
  function uncopen() {
    SMB_PATH=`unc2smb $@`
    open ${SMB_PATH}
  }
fi
## if brew exists 
if which brew > /dev/null 2>&1; then
  BREW_PREFIX=`brew --prefix`
  ### z
  if [ -f ${BREW_PREFIX}/etc/profile.d/z.sh ];then
    . ${BREW_PREFIX}/etc/profile.d/z.sh
    function precmd () {
      z --add "$(pwd -P)"
    }
  fi
fi

# vimrc
if [ -f ~/dotfiles/.vimrc ]; then
  if [ -z "${VIM_COMMAND}" ]; then
    VIM_COMMAND=vim
  fi
  alias vim="${VIM_COMMAND} -u ~/dotfiles/.vimrc"
  alias vimrc="vim ~/dotfiles/.vimrc"
fi
