## PATH
export PATH=~/bin/:$PATH
export GOPATH=$HOME
export EDITOR="vim"

## enable color
autoload -Uz colors
colors

## complete
autoload -U compinit
compinit

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
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

## word
autoload -Uz select-word-style
select-word-style default
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

if [ -f ~/.bash_alias ]; then
    . ~/.bash_alias
fi

fzf-src() {
	local dir
	dir=$(ghq list -p | fzf --preview "bat --color=always --style=header,grid --line-range :80 {}/README.*")
	if [ -n $dir ]; then
		BUFFER="cd $dir"
		zle accept-line
	fi
	zle clear-screen
}
zle -N fzf-src
bindkey '^]' fzf-src

