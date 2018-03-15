function fzy_select_history
    history | fzy | read foo

    if [ $foo ]
	commandline $foo
    else
	commandline ''
    end
    commandline -f repaint
end

function fzy_ghq_cd
    ghq list --full-path | fzy | read foo

    if [ $foo ]
	builtin cd $foo
    else
	commandline ''
    end
    commandline -f repaint
end
