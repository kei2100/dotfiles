# navigate
alias ls='ls -G'
alias ll='ls -l'
alias la='ls -la'
alias l='la'

# git
alias gs='git status'
alias gb='git branch'
alias gl='git log'
alias gd='git diff'
alias gam='git commit --amend'
alias gcm='git checkout master'
alias gcd='git checkout develop'
alias gcb='git checkout -b'
alias gpom='git pull origin master'
alias gpum='git pull upstream master'
alias gpud='git pull upstream develop'

function gpo() {
  local B=$(git branch | grep '^* ' | perl -pe 's/^\* //gc')
  git push origin $B
}

function gfpr() {
  git fetch upstream pull/$@/head:pr-$@
}

# history
HISTSIZE=30000
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

  if [ -f ${BREW_PREFIX}/etc/bash_completion ]; then
    . ${BREW_PREFIX}/etc/bash_completion
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
    local REPODIR=repos
    REPODIR=$(echo ${REPODIR} | perl -pe 's|(^/).+(/$)||')
    local DIR=$(find ~/${REPODIR} -type d -o -type l -mindepth 3 -maxdepth 3 | perl -pe "s|`echo $(cd ~ && pwd)/${REPODIR}/`||" | peco)
    [ ! -z $DIR ] && cd -P ~/${REPODIR}/${DIR}
  }
fi

# tmux
if [ -f ~/dotfiles/.tmux.conf ]; then
  alias tmux="tmux -f ~/dotfiles/.tmux.conf"
fi

# bashrc
alias bashrc='nvim ~/dotfiles/.bashrc'

# git diff-highlight
[ -z "${GIT_DIFF_HIGHLIGHT_PATH}" ] && GIT_DIFF_HIGHLIGHT_PATH=/usr/local/share/git-core/contrib/diff-highlight
[ -d ${GIT_DIFF_HIGHLIGHT_PATH} ] && export PATH=${GIT_DIFF_HIGHLIGHT_PATH}:${PATH}

