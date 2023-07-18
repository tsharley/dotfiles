#!/usr/bin/env bash
if tput setaf 1 &> /dev/null
then	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);
	# Solarized colors, taken from http://git.io/solarized-colors.
	black=$(tput setaf 0);
	blue=$(tput setaf 33);
	cyan=$(tput setaf 37);
	green=$(tput setaf 64);
	orange=$(tput setaf 166);
	purple=$(tput setaf 125);
	red=$(tput setaf 124);
	violet=$(tput setaf 61);
	white=$(tput setaf 15);
	yellow=$(tput setaf 136);
else
	bold='';
	reset="\e[0m";
	black="\e[1;30m";
	blue="\e[1;34m";
	cyan="\e[1;36m";
	green="\e[1;32m";
	orange="\e[1;33m";
	purple="\e[1;35m";
	red="\e[1;31m";
	violet="\e[1;35m";
	white="\e[1;37m";
	yellow="\e[1;33m";
fi;

#custom_prompt(){
#    PS1='\[\e[38;5;160m\]\u \[\e[38;5;93m\]@ \H \[\e[38;5;160m\]\w\[\e[38;5;93m\]\$ \[\e[0m\]'
#    PS1='\[\e[38;5;160m\]ROOT \[\e[38;5;93m\]\[\e[38;5;160m\]\w\[\e[38;5;93m\]\$ \[\e[0m\]'
#}
#custom_prompt

function set_prompt() {
  PS1='';
  PS1+='\n ${cyan}(${purple}${cyan}) ';
  PS1+='${cyan}\u'; # username
  PS1+='${purple}@'; # '@'
  PS1+='${cyan}\H'; # hostname (H=full, h=short)
  PS1+='${purple}: \w    ${green}\d, \@${reset}\n'; # working directory full path
  PS1+='${purple} (\s)${reset}'; # shell
  PS1+='${cyan}-\$ ${reset}'; # prompt sign
  export PS1;
}

set_prompt

# Red/Purple
# PS1='\[\e[38;5;160m\]\u \[\e[38;5;93m\]@ \H \[\e[38;5;160m\]\w\[\e[38;5;93m\]\$ \[\e[0m\]'
