#!/usr/bin/env bash
# Define dotfiles location, exports and command path
DOTDIR="${HOME}/.dotfiles"; export DOTDIR
_ddsrc(){
	for f in "${@}"; do [[ -r "${DOTDIR}/${f}" ]] && . "${DOTDIR}/${f}"; done
}
_ddsrc exports
[[ -r "${HOME}/.$(hostname -s).rc" ]] && . "${HOME}/.$(hostname -s).rc"
# Options
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"
shopt -s histappend
shopt -s checkwinsize
_ddsrc paths themes aliases functions pyvenvw
# enable color support of ls
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
  fi
fi
# Initialize fuzzer
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
