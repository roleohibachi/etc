#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

alias vi='vim'

#roleo says this sucks... alias npp="env WINEPREFIX=\"/home/roleo/.wine\" wine C:\\\Program\\ Files\\ \\(x86\\)\\\Notepad++\\\notepad++.exe"
alias auth="oathtool --totp -b `head -1 ~/.google_authenticator`"
alias ksp="/mnt/storage/SteamLibrary/steamapps/common/Kerbal\ Space\ Program/pulsenomore.x86_64 /mnt/storage/SteamLibrary/steamapps/common/Kerbal\ Space\ Program/KSP.x86_64"

#PS1='[\u@\h \W]\$ '
function timer_start {
	timer=${timer:-$SECONDS}
}

function timer_stop {

	local EXIT=`echo $?`

	PS1="["

	local RCol='\[\e[0m\]'
	local Red='\[\e[0;31m\]'
	local Gre='\[\e[0;32m\]'
	
	if [ $EXIT != 0 ]; then
		PS1+="${Red}$EXIT${RCol}"      # Add red if exit code non 0
	else
		PS1+="${Gre}$EXIT${RCol}"
	fi

	timer_show=$(($SECONDS - $timer))
	unset timer
	PS1+=' in ${timer_show}s]\n[\u@\h][\w]$ '
}

trap 'timer_start' DEBUG
PROMPT_COMMAND=timer_stop

