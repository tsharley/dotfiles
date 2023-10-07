#!/usr/bin/env bash

# Define dotfiles location, exports and command path
DOTDIR=~/.dotfiles
export DOTDIR
. "${DOTDIR}"/exports
. "${DOTDIR}"/paths
#export PATH


# Options
#[ -r "/etc/bashrc_$TERM_PROGRAM" ] && . "/etc/bashrc_$TERM_PROGRAM"
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
shopt -s histappend
shopt -s checkwinsize


# Setup prompt
. "$DOTDIR"/themes
_set_theme green
#. "$HOME/.local/bin/promptcraft"

# Source utility configs
[ -r "${DOTDIR}"/aliases ] && . "${DOTDIR}"/aliases
[ -r "${DOTDIR}"/functions ] && . "${DOTDIR}"/functions


# Run any available common startup scripts or local-only scripts
. "${DOTDIR}"/pyvewrc 
#_run_scripts "${DOTDIR}"/bashrc.d
#_run_scripts "${HOME}"/.local/bashrc.d


# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

_vivid_colors(){
#	_cs=alabaster_dark
#	_cs=ayu
#	_cs=catppuccin-frappe
#	_cs=catppuccin-latte
#	_cs=catppuccin-macchiato
#	_cs=catppuccin-mocha
#	_cs=dracula
#	_cs=gruvbox-dark
#	_cs=gruvbox-dark-hard
#	_cs=gruvbox-dark-soft
#	_cs=gruvbox-light
#	_cs=gruvbox-light-hard
#	_cs=gruvbox-light-soft
#	_cs=iceberg-dark
#	_cs=jellybeans
#	_cs=lava
#	_cs=modus-operandi
#	_cs=molokai
#	_cs=nord
#	_cs=one-dark
#	_cs=one-light
#	_cs=snazzy
	_cs=solarized-dark
#	_cs=solarized-light
	LS_COLORS="$(vivid generate "${_cs}")"
	export LS_COLORS
}

[ "$(command -v vivid)" != '' ] && _vivid_colors

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Source completion if available
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

