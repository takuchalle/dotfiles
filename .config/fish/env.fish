set -x LANG en_US.utf8

if type rbenv > /dev/null;
	status --is-interactive; and source (rbenv init -|psub)
end

# PATH
set fish_user_paths ~/bin $fish_user_paths
set fish_user_paths /usr/local/bin $fish_user_paths

set -x GOPATH $HOME

set -x EDITOR "emacsclient -nw"
