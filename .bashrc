# navigate
alias ls='ls -G'
alias ll='ls -l'
alias la='ls -la'

# git
alias gs='git status'
alias gb='git branch'
alias gl='git log'
alias gd='git diff'
alias ga='git add'
alias gc='git checkout'
alias gmm='git commit -m'
alias gam='git commit --amend'
alias gcm='git checkout main'
alias gcd='git checkout develop'
alias gsm='git switch main'
alias gsd='git switch develop'
alias gcb='git checkout -b'
alias gpom='git pull origin main'
alias gpod='git pull origin develop'
alias gpum='git pull upstream main'
alias gpud='git pull upstream develop'

function gpo() {
  local B=$(git branch | grep '^* ' | perl -pe 's/^\* //gc')
  git push origin $B
}

function gsddb() {
  local B=$(git branch | grep '^* ' | perl -pe 's/^\* //gc')
  git switch develop && git pull origin develop && git branch -d $B
}

function gsmdb() {
  local B=$(git branch | grep '^* ' | perl -pe 's/^\* //gc')
  git switch main && git pull origin main && git branch -d $B
}

function gfpr() {
  git fetch origin pull/$@/head:pr-$@
}

# history
HISTSIZE=30000
HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S "
HISTCONTROL=ignoredups

# functions
function _find_cmd() {
  which $1 2>/dev/null
}

# pbcopy,pbpaste (osx)
if [ -n "$(_find_cmd pbcopy)" ]; then
  alias pb='perl -pe "chomp" | pbcopy && pbpaste'
fi

# brew
if [ -n "$(_find_cmd brew)" ]; then
  BREW_PREFIX=`brew --prefix`
  [[ -r "${BREW_PREFIX}/etc/profile.d/bash_completion.sh" ]] && . "${BREW_PREFIX}/etc/profile.d/bash_completion.sh"
fi

# fzf
if [ -n "$(_find_cmd fzf)" ]; then
  export FZF_DEFAULT_OPTS='--reverse'
  function fbd() {
    local PRE_IFS=$IFS
    IFS=$'\n'

    local parent=$(for d in $(pwd | perl -pe 's|/|\n|gc' | tail -r); do
      local p=$p../; echo $p$d;
    done | fzf)

    IFS=$PRE_IFS
    [ -n "$parent" ] && cd "$parent"
  }

  function frepo() {
    local DIR=$(find ~/repos \( -type d -o -type l \) -mindepth 3 -maxdepth 3 | perl -pe "s|${HOME}/repos/||" | fzf)
    [ ! -z $DIR ] && cd -P ~/repos/${DIR}
  }

  function fhistory() {
    local CMD=$(HISTTIMEFORMAT="%Y/%m/%d %H:%M:%S - "  history | tail -r | fzf)
    CMD=`echo ${CMD} | perl -pe 's/.+? - (.+)/$1/gc'`
    history -s ${CMD}
    eval ${CMD}
  }
fi

# peco
if [ -n "$(_find_cmd peco)" ]; then
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
alias bashrc='vim ~/dotfiles/.bashrc'

# git diff-highlight
[ -z "${GIT_DIFF_HIGHLIGHT_PATH}" ] && GIT_DIFF_HIGHLIGHT_PATH=/usr/local/share/git-core/contrib/diff-highlight
[ -d ${GIT_DIFF_HIGHLIGHT_PATH} ] && export PATH=${GIT_DIFF_HIGHLIGHT_PATH}:${PATH}


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
