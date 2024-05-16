#!/usr/bin/env bash
##############################################################################%

# Define dotfiles location, exports and command path
##############################################################################%
DOTDIR="${HOME}/.dotfiles"; export DOTDIR
dot_dir_src(){
	for f in "${@}"; do
		[[ -r "${DOTDIR}/${f}" ]] && . "${DOTDIR}/${f}"
	done
}
dot_dir_src exports

# Source host-specific config if available
##############################################################################%
[[ -r "${HOME}/.$(hostname -s).rc" ]] && . "${HOME}/.$(hostname -s).rc"

# Basic Shell Options (history, globbing, etc.)
##############################################################################%
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"
shopt -s histappend; shopt -s checkwinsize

# Source main dotfiles and setup function for overrides
##############################################################################%
dot_dir_src paths themes aliases functions pyvenvw
dolastrc() { for item in ~/.local/init/*; do source "$item"; done; }

# Customize tools, completions, etc.
##############################################################################%
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || \
    eval "$(dircolors -b)"
fi
# Standard bash completions
if ! shopt -oq posix; then
  if [[ -f /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
  elif [[ -f /etc/bash_completion ]]; then
    . /etc/bash_completion
  fi
fi
# completions from ssh config
[[ -e "$HOME/.ssh/config" ]] && complete -o "default" \
	-o "nospace" -W "$(grep "^Host" ~/.ssh/config | \
	grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
if [[ $(rbenv version) ]]; then eval "$(rbenv init - bash)"; fi

# Call function to enable local overrides if present
##############################################################################%
dolastrc
source "$RYE_HOME/env"
