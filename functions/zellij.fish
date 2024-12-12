#!/opt/homebrew/bin/fish


# -*- tab-width: 2; encoding: utf-8 -*-

#= file: $HOME/.config/fish/functions/zellij.fish


function __zellij::auto_start
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

#= start(auto) zellij
#set -q ZELLIJ_AUTO_START || set -U ZELLIJ_AUTO_START true
#set -q ZELLIJ_AUTO_EXIT || set -U ZELLIJ_AUTO_EXIT true

#zellij setup --generate-completion fish | source


#if type zellij-auto-start >/dev/null 2>&1
#    zellij-auto-start
#end

#= start(auto) zellij
#eval ( zellij setup --generate-auto-start fish | string collect )
end


function __zellij::auto_exit:disable
	set -U ZELLIJ_AUTO_EXIT false
end


function __zellij::auto_start:disable
	set -U ZELLIJ_AUTO_START false
end


function __zellij::auto_exit:enable
	set -U ZELLIJ_AUTO_EXIT true
end


function __zellij::auto_start:enable
	set -U ZELLIJ_AUTO_START true
end


# vim:ft=fish
