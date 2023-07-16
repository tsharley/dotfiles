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
  for directory in ${dirs_list[@]}; do
    if [ ! -d "$HOME/$directory" ]
    then
      mkdir -p "$HOME/$directory"
    fi
  done
}

_make_startuprc() {
  cat << 'EOF' >> ~/.config/startup.rc
  #!/usr/bin/env bash  
  # If not running interactively, don't do anything
  [ -z "$PS1" ] && return
  
  # Source files
  . ~/.config/defaults.sh
  . ~/.config/prompt.sh
  . ~/.config/exports.sh
  . ~/.config/functions.sh
  . ~/.config/aliases.sh
  . ~/.config/path.sh
  
  # In case additional local scripts are needed
  run_scripts(){
    for script in $1/*; do
      [ -x "$script" ] || continue
      . $script
    done
  }
  run_scripts $HOME/.bashrc.d
EOF
}

_make_links(){
  ln -s ~/.config/dotfiles/defaults.sh ~/.config/
  ln -s ~/.config/dotfiles/prompt.sh ~/.config/
  ln -s ~/.config/dotfiles/exports.sh ~/.config/
  ln -s ~/.config/dotfiles/functions.sh ~/.config/
  ln -s ~/.config/dotfiles/aliases.sh ~/.config/
  ln -s ~/.config/dotfiles/path.sh ~/.config/
}

_install() {
  [[ "$(uname)" == "Darwin" ]] && _rc=".zshrc" || _rc=".bashrc"
  _make_directories
  cp "${HOME}/${_rc}" "${HOME}/.config/backup/${_rc}.$(date +%s)"
  mv /etc/nanorc /etc/nanorc.bak
  ln -s $(pwd)/nanorc /etc/nanorc
  echo '. $HOME/.config/startup.rc' > "${HOME}/${_rc}"
  _make_startuprc
  _make_links
  echo "Synced.  Source ${_rc} when ready."
}

_install
