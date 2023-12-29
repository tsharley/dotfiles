#!/usr/bin/env bash


# Define dotfiles location, exports and command path

DOTDIR="${HOME}/.dotfiles"; export DOTDIR

DotDirSrc(){
	for f in "${@}"; do
		[[ -r "${DOTDIR}/${f}" ]] && . "${DOTDIR}/${f}"
	done
}

DotDirSrc exports


# Source host-specific config if available

[[ -r "${HOME}/.$(hostname -s).rc" ]] && \
. "${HOME}/.$(hostname -s).rc"


# Options

[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

shopt -s histappend
shopt -s checkwinsize


# Source remaining curated dotfiles

DotDirSrc paths themes aliases functions pyvenvw


# Customize tools, completions, etc.

if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || \
    eval "$(dircolors -b)"
fi

if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion			# Standard bash completions
  fi
fi

[[ -e "$HOME/.ssh/config" ]] && complete -o "default" \
	-o "nospace" \
	-W "$(grep "^Host" ~/.ssh/config | \
	grep -v "[?*]" | cut -d " " -f2 | \
	tr ' ' '\n')" scp sftp ssh		# completions based on ssh config

[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
if [[ $FF_SHOWN != 0 && $(uname) == "Darwin" ]]; then
	c; fastfetch -c ~/.config/fastfetch/modules.min.jsonc
	FF_SHOWN=0; export FF_SHOWN
fi

eval "$(rbenv init - bash)"
