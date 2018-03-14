# environment
. ~/.config/fish/env.fish

# alias
alias em "emacsclient -t"

# local setting
if test -e ~/.config/fish/local.fish
    . ~/.config/fish/local.fish
end

if not test -f ~/.config/fish/functions/fisher.fish
    echo "==> Fisherman not found.  Installing."
    curl -sLo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
    fisher
end
