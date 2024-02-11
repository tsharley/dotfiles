#!/usr/bin/env bash
####################

# Define dotfiles location, exports and command path
#####################################################
DOTDIR="${HOME}/.dotfiles"; export DOTDIR

dot_dir_src(){
	for f in "${@}"; do
		[[ -r "${DOTDIR}/${f}" ]] && . "${DOTDIR}/${f}"
	done
}

dot_dir_src exports


# Source host-specific config if available
###########################################
[[ -r "${HOME}/.$(hostname -s).rc" ]] && \
. "${HOME}/.$(hostname -s).rc"


# Basic Shell Options (history, globbing, etc.)
################################################
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

shopt -s histappend
shopt -s checkwinsize


# Source main dotfiles and setup function for overrides
########################################################
dot_dir_src paths themes aliases functions pyvenvw

dolastrc() {
	if ! mtdir ~/.local/init; then
		for item in ~/.local/init/*; do
			source "$item"
		done
	fi
}


# Customize tools, completions, etc.
#####################################

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
#if [[ $FF_SHOWN != 0 && $(uname) == "Darwin" ]]; then
#	c; fastfetch -c ~/.config/fastfetch/modules.min.jsonc
#	FF_SHOWN=0; export FF_SHOWN
#fi

if [[ $(rbenv version) ]]; then
  eval "$(rbenv init - bash)"
fi

# Call function to enable local overrides if present
#####################################################
dolastrc
