# environment
. ~/.config/fish/env.fish

# load functions
. ~/.config/fish/functions.fish

function fish_user_key_bindings
    bind \cr fzy_select_history
    bind \c] fzy_ghq_cd
end

# alias
alias em "emacsclient -t"
alias be "bundle exec"

# local setting
if test -e ~/.config/fish/local.fish
    . ~/.config/fish/local.fish
end

if not test -f ~/.config/fish/functions/fisher.fish
    echo "==> Fisherman not found.  Installing."
    curl -sLo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
    fisher
end
