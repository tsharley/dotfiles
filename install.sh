#!/usr/bin/env bash

function _make_directories() {
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

function _make_startuprc() {
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

function _make_links(){
  ln -s ~/.config/dotfiles/defaults.sh ~/.config/
  ln -s ~/.config/dotfiles/prompt.sh ~/.config/
  ln -s ~/.config/dotfiles/exports.sh ~/.config/
  ln -s ~/.config/dotfiles/functions.sh ~/.config/
  ln -s ~/.config/dotfiles/aliases.sh ~/.config/
  ln -s ~/.config/dotfiles/path.sh ~/.config/
}

function _install_required_packages() {
  apt update
  apt -y install $(cat packages.list)
}

function _install_docker() {
  for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do apt-get remove $pkg; done
  apt-get update
  apt-get install ca-certificates curl gnupg
  install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
  chmod a+r /etc/apt/keyrings/docker.gpg
  echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
  apt-get update
  apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

function _main() {
  apt update
  apt upgrade -y
  [[ "$(uname)" == "Darwin" ]] && _rc=".zshrc" || _rc=".bashrc"
  _make_directories
  cp "${HOME}/${_rc}" "${HOME}/.config/backup/${_rc}.$(date +%s)"
  mv /etc/nanorc /etc/nanorc.bak
  ln -s $(pwd)/nanorc /etc/nanorc
  echo '. $HOME/.config/startup.rc' > "${HOME}/${_rc}"
  _make_startuprc
  _make_links
  _install_required_packages
  _install_docker
  apt autoremove
  echo "Synced.  Source ${_rc} when ready."
}

_main
