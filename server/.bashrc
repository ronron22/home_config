# Only do stuff if in bash
if [ ! -n "${BASH}" ]; then
	return
fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source auto-completion
for DIR in /etc /usr/share/bash-completion; do
        [ -f ${DIR}/bash_completion ] && source ${DIR}/bash_completion
done

# Add colors to ls
eval "`dircolors 2>/dev/null`"
export LS_OPTIONS='--color=auto --group-directories-first'

# Aliases
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -lh'
alias la='ls $LS_OPTIONS -lah'
alias l='ll'
alias vi='vim'
alias pstree='pstree -A'

HISTSIZE=10000
HISTFILESIZE=$HISTSIZE
HISTCONTROL=ignoredups
CYAN=$(echo -e '\e[0;36m')
NORMAL=$(echo -e '\e[0m')
HISTTIMEFORMAT="${CYAN}[ %d/%m/%Y %H:%M:%S ]${NORMAL}  "

unset MAILCHECK
export EDITOR=vim
export PAGER=less
export SYSTEMD_PAGER=cat
export GIT_PAGER=cat
export LESS='-R'

if [ -f /usr/share/git/git-prompt.sh ]; then
        source /usr/share/git/git-prompt.sh
fi

if type __git_ps1 &>/dev/null ; then
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    export GIT_PS1_SHOWSTASHSTATE=true
    GIT_BRANCH="\`__git_ps1\`"
fi

CYAN="\[$(tput setaf 6)\]"
BLUE="\[$(tput setaf 4)\]"
PURPLE="\[$(tput setaf 5)\]"
BOLD="\[$(tput bold)\]"
NORMAL="\[$(tput sgr0)\]"

PS1="${CYAN}\u${PURPLE}@\h:${NORMAL}\w${BLUE}${BOLD}${GIT_BRANCH}${NORMAL} \\$ "

export PS1
PROMPT_COMMAND="history -a"
