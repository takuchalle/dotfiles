## PATH
export PATH=~/bin/:$PATH
export GOPATH=$HOME
export EDITOR="emacsclient -nw"

## enable color
autoload -Uz colors
colors

## emacs key bind
bindkey -e

## Left Prompt
PROMPT="%{${bg[red]}%}%T%{${reset_color}%} %~ > "

## disable beep
setopt no_beep

## history seting
setopt share_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

## word
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

## Alias
if type exa > /dev/null 2>&1; then
	## brew install exa
	alias ls='exa --git'
	alias la='exa -a --git'
	alias ll='exa -lab --git'
	alias tree='exa --tree'
else
case ${OSTYPE} in
	darwin*)
		export CLICOLOR=1
		alias ls='ls -G -F'
		;;
	linux*)
		alias ls='ls -F --color=auto'
		;;
esac
alias g=git

fi

## Functions
fe() {
	local files
	IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
	[[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

fd() {
	local dir
	dir=$(find ${1:-.} -path '*/\.*' -prune \
	           -o -type d -print 2> /dev/null | fzf +m) &&
		cd "$dir"
}

# fh - repeat history
fh() {
	eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -r 's/ *[0-9]*\*? *//' | sed -r 's/\\/\\\\/g')
}
zle -N fh
bindkey '^r' fh

fzf-src() {
	local dir
	dir=$(ghq list -p | fzf +m)
	if [ -n $dir ]; then
		BUFFER="cd $dir"
		zle accept-line
	fi
	zle clear-screen
}
zle -N fzf-src
bindkey '^]' fzf-src

em() {
	local file
	if [ $1 ]; then
		emacsclient -nw $1
	else
		file=$(([ -n "$ZSH_NAME" ] && fc -l 1 || history) | grep em | fzf -0 -1 | awk '{print $NF}')

		echo $file
		if [ -e $file ]; then
			emacsclient -nw $file
		fi
	fi
}
