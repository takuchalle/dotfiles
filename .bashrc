# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# PATH
export GOPATH=$HOME
export PATH=$GOPATH/bin:$PATH

export EDITOR="emacsclient -t"

# alias
alias em="emacsclient -t"
alias be="bundle exec"

if [ -f ~/.bash_secret ]; then
    . ~/.bash_secret
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPTS="--extended --cycle --select-1 --exit-0"

fzf-src() {
	local selected
	selected="$(ghq list --full-path | fzf --query="$READLINE_LINE")"
	if [ -n "$selected" ]; then
		READLINE_LINE="builtin cd $selected"
		READLINE_POINT=${#READLINE_LINE}
	fi
}
bind -x '"\C-]": fzf-src'

if [ -f $(ghq list --full-path | grep "git/git")/contrib/completion/git-prompt.sh ]; then
	export GIT_PS1_SHOWDIRTYSTATE=1
	export PS1='[\w]$(__git_ps1 " (%s)")\$ '
fi
