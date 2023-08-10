#!/usr/bin/env bash

# Env Vars for terminal and OS/FS structure
###########################################

## Cross-platform ##

# XDG Base Structure
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_RUNTIME_DIR="$HOME/.local/bin/run"

# Fall through to available editor; picked up in 
# subsequent aliases and functions
if [ -n "$(which micro)" ]; then
    EDITOR="$(which micro)"
elif [ -n "$(which nano)" ]; then
    EDITOR="$(which nano)"
elif [ -n "$(which vim)" ]; then
    EDITOR="$(which vim)"
else
    EDITOR=/usr/bin/vi
fi
export EDITOR
export VISUAL="$EDITOR"
export SUDO_EDITOR="$EDITOR"

# State controls
export HISTFILE="$ZDOTDIR/.zhistory"              # History filepath
export HISTSIZE=100000                            # Maximum events for internal history
export SAVEHIST=100000                            # Maximum events in history file
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups:ignorespace
export LESSHISTFILE="$HOME/CACHE/less/history"

# App Specific
export PSQL_HISTORY="$XDG_DATA_HOME/psql_history"
export DOCKER_CLI_HINTS=false
