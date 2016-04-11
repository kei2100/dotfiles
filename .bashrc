# alias
alias ls='ls -G'
alias ll='ls -l'
alias l='ll'

# git
alias gs='git status'
alias gb='git branch'
alias gcm='git checkout master'
alias gcd='git checkout develop'
alias gcb='git checkout -b'
alias gpom='git pull origin master'
alias gpud='git pull upstream develop'

function lsb() {
  CUR=$(pwd)
  for DIR in $(find ./*/.git -type d -maxdepth 0 | perl -pe 's|^\./(.+)/\.git|$1|'); do
    echo ${DIR}
    cd ${DIR} && git branch
    cd ${CUR}
  done
}

function gclb() {
  local B=$(git branch | grep '^* ' | perl -pe 's/^\* //gc')
  if [ "$B" == "develop" ]; then
    echo "$B"
    return
  fi

  git checkout develop && git pull upstream develop && git branch -d $B
}

function grbd() {
  local B=$(git branch | grep '^* ' | perl -pe 's/^\* //gc')
  if [ "$B" == "develop" ]; then
    echo "$B"
    return
  fi

  git checkout develop && git pull upstream develop && git checkout $B && git rebase develop
}

# history
HISTSIZE=10000
HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S "

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
  if [ -f ${BREW_PREFIX}/etc/profile.d/z.sh ]; then
    . ${BREW_PREFIX}/etc/profile.d/z.sh
    function precmd () {
      z --add "$(pwd -P)"
    }
  fi
fi

# peco
if which peco > /dev/null 2>&1; then
  alias peco="peco --rcfile ~/dotfiles/.peco/config.json"

  function pessh() {
    local OPT=$@
    local HOST=$(cat ~/.ssh/known_hosts | awk "{print \$1}" | perl -pe "s/,.+//" | peco)
    history -s pessh ${OPT}
    history -s ssh "${OPT} ${HOST}"
    ssh ${OPT} ${HOST}
  }

  pehistory() {
    local CMD=$(HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S - "  history | tail -r | peco)
    CMD=`echo ${CMD} | perl -pe 's/.+? - (.+)/$1/gc'`
    history -s ${CMD}
    eval ${CMD}
  }

  perepo() {
    local REPODIR=localrepos
    REPODIR=$(echo ${REPODIR} | perl -pe 's|(^/).+(/$)||')
    local DIR=$(find ~/${REPODIR} -type d -mindepth 3 -maxdepth 3 | perl -pe "s|`echo $(cd ~ && pwd)/${REPODIR}/`||" | peco)
    cd ~/${REPODIR}/${DIR}
  }
fi

# vimrc
if [ -f ~/dotfiles/.vimrc ]; then
  if [ -z "${VIM_COMMAND}" ]; then
    VIM_COMMAND=vim
  fi
  if [ -z "${VIMDIFF_COMMAND}" ]; then
    VIMDIFF_COMMAND=vimdiff
  fi
  alias vim="${VIM_COMMAND} -u ~/dotfiles/.vimrc"
  alias vimdiff="${VIMDIFF_COMMAND} -u ~/dotfiles/.vimrc"
  alias vimrc="vim ~/dotfiles/.vimrc"
fi

# tmux
if [ -f ~/dotfiles/.tmux.conf ]; then
  alias tmux="tmux -f ~/dotfiles/.tmux.conf"
fi

# bashrc
alias bashrc='vim ~/dotfiles/.bashrc'

# ctags
if [ -f ~/dotfiles/.ctags ]; then
  alias ctags="ctags --options=$(cd ~/dotfiles && pwd)/.ctags"
fi

# git completion
# https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
# https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh
if [ -z "${GIT_COMPLETION_PATH}" ]; then
  #GIT_COMPLETION_PATH=~/localrepos/local/git/git-completion.bash
  GIT_COMPLETION_PATH=~/localrepos/local/git
fi
if [ -d ${GIT_COMPLETION_PATH} ]; then
#  source ${GIT_COMPLETION_PATH}/git-prompt.sh
  source ${GIT_COMPLETION_PATH}/git-completion.bash
#  GIT_PS1_SHOWDIRTYSTATE=true
#  export PS1='\[\033[00m\]\W\[\033[30m\]$(__git_ps1)\[\033[00m\] \$ '
fi

# utils
function unix2() {
  local UNIXTIME
  if [ -p /dev/stdin ]; then
    UNIXTIME=$(cat -)
  else
    UNIXTIME=$@
  fi
  echo ${UNIXTIME} | ruby -ne 'n=Time.now(); t=Time.at($_.to_i); puts sprintf("%d\t%s\t%f\t%f\t%d", $_, t, (t-n)/3600, (t-n)/60, t-n)'
}
