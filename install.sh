#!/usr/bin/env bash

set -eu -o pipefail # fail on error and report it, debug all lines

echo 'Verifying elevated privelege.  Script will abort if not root/sudo.'
sudo -n true
test $? -eq 0 || exit 1

echo installing the must-have pre-requisites
while read -r p ; do sudo apt-get install -y "$p" ; done < <(cat << "EOF"
    perl
    zip unzip
    exuberant-ctags
    mutt
    libxml-atom-perl
    postgresql-9.6
    libdbd-pgsql
    curl
    wget
    libwww-curl-perl
    rsync
    git
    curl
    sudo
    tree
    exa
    iputils-arping
    iputils-clockdiff
    iputils-ping
    iputils-tracepath
    lsm
    ca-certificates
    gnupg
    apt-file
EOF
)

echo installing the nice-to-have pre-requisites
echo you have 5 seconds to proceed ...
echo or
echo hit Ctrl+C to quit
echo -e "\n"
sleep 6

sudo apt-get install -y tig
export DOTDIR=$HOME/.config/dotfiles

function _make_directories() {
    while IFS= read -r line
    do
        mkdir "$line" 2>/dev/null
    done < <(cat "${1}")
}

function _make_links(){
    ln -s "$DOTDIR"/scripts/* ~/.config/startup.d/
}

function _install_required_packages() {
    apt-get update
    apt-get install "$(cat "${DOTDIR}"/install/packages.list)"
    apt autoremove
}

function _install_docker() {
    if [ -f /etc/apt/keyrings/docker.gpg ];
    then
        for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do apt-get remove $pkg; done
        apt-get update
        apt-get install ca-certificates curl gnupg
        install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        chmod a+r /etc/apt/keyrings/docker.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
        apt-get update
        apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    fi
}

function _remaining_configs() {
    chmod +x "$DOTDIR"/install/editors.sh
    ./"$DOTDIR"/install/editors.sh
}

function main() {
    [[ "$(uname)" == "Darwin" ]] && _rc="$HOME/.zshrc" || _rc="$HOME/.bashrc"
    _make_directories "$DOTDIR"/install/mkdirs.list
    _make_links
    _install_required_packages
    _install_docker
    _remaining_configs
    apt autoremove
    echo "Synced.  Source ${_rc} when ready."
}

# main
_install_required_packages
