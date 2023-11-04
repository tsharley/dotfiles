#!/usr/bin/env bash

# Define dotfiles location, exports and command path
DOTDIR="${HOME}/.dotfiles"
export DOTDIR
. "${DOTDIR}"/exports

# Host-specific config
[ -r "${HOME}/.$(hostname -s).rc" ] && . "${HOME}/.$(hostname -s).rc"

. "${DOTDIR}"/paths

# Options
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
shopt -s histappend
shopt -s checkwinsize

# Setup prompt
. "${DOTDIR}"/themes
if [[ -n $SSH_CLIENT ]]; then
    _set_theme maroon
else
    _set_theme green
fi

. ~/.config/bash/theme/frost.theme

# Source utility configs
[ -r "${DOTDIR}"/aliases ] && . "${DOTDIR}"/aliases
[ -r "${DOTDIR}"/functions ] && . "${DOTDIR}"/functions

# Run any available common startup scripts or local-only scripts
. "${DOTDIR}"/pyvenvw
#_run_scripts "${DOTDIR}"/bashrc.d
#_run_scripts "${HOME}"/.local/bashrc.d

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# source host-specific config if available
[ -e "${HOME}"/.mba2020.rc ] && . "${HOME}"/.mba2020.rc

# Source completion if available
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Hishtory Config:
export PATH="$PATH:/Users/tjsharley/.hishtory"
source /Users/tjsharley/.hishtory/config.sh
