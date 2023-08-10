# ~/.bashrc: executed by bash(1) for non-login shells.

DOTDIR='$HOME/.config/dotfiles'
export DOTDIR
[ x "${DOTDIR}"/exports ] && "${DOTDIR}"/exports

# Setup prompt
. "$DOTDIR"/setprompt

[ x "${DOTDIR}"/aliases ] && "${DOTDIR}"/aliases
[ x "${DOTDIR}"/functions ] && "${DOTDIR}"/functions
[ x "${DOTDIR}"/paths ] && "${DOTDIR}"/paths

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Try to source completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
