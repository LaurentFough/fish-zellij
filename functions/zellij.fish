function __zellij::auto-start
    set -q ZELLIJ_PANE_ID && return

    set -U ZELLIJ_DISABLE_AUTO_EXIT_ONLY_ONCE false

    set current_number ( zellij list-sessions | rg "automatic-(\w+)" -or '$1' | sort -rV | head -n 1 )
    test -z "$current_number" && set current_number 0
    set new_number ( math "$current_number" + 1 )

    if $ZELLIJ_AUTO_START
        zellij -s "automatic-$new_number" || exit

        if $ZELLIJ_AUTO_EXIT
            if not $ZELLIJ_DISABLE_AUTO_EXIT_ONLY_ONCE
                kill $fish_pid
            end
        end
    end
end


function __zellij::auto-exit:disable
    set -U ZELLIJ_AUTO_EXIT false
end


function __zellij::auto-start:disable
    set -U ZELLIJ_AUTO_START false
end


function __zellij::auto-exit:enable
    set -U ZELLIJ_AUTO_EXIT true
end


function __zellij::auto-start:enable
    set -U ZELLIJ_AUTO_START true
end
