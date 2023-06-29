#!/usr/bin/env bash

_make_directories() {
  dirs_list=(
    .config/backup
    .config/startup.d
    .local/lib
    .local/bin/run
    .local/share
    .local/state
    .cache
    )
  for directory in ${dirs_list[@]}
    do
      if [ ! -d "$HOME/$directory" ]
        then
          mkdir -p "$HOME/$directory"
      fi
  done    
}

_install() {
  [[ "$(uname)" == "Darwin" ]] && _rc=".zshrc" || _rc=".bashrc"
  cp "${HOME}/${_rc}" "${HOME}/.config/backup/${_rc}.$(date +%s)"
  echo '. $HOME/.config/'"$startup_script" > "${HOME}/${_rc}"
  echo "Synced.  Source ${_rc} when ready."
}
