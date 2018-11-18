set -x LANG en_US.utf8

# PATH
set fish_user_paths ~/bin $fish_user_paths

set -x GOPATH $HOME

set -x EDITOR "emacsclient -nw"

if type rbenv > /dev/null;
	status --is-interactive; and source (rbenv init -|psub)
end
