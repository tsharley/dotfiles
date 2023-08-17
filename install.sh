#!/usr/bin/env bash

set -eu -o pipefail # fail on error and report it, debug all lines

echo 'Verifying elevated privelege.  Script will abort if not root/sudo.'
sudo -n true
test $? -eq 0 || exit 1

DOTDIR=~/.config/dotfiles
export DOTDIR

function _make_directories() {
    while IFS= read -r line
    do
        if [[ "${line}" =~ ^#.*$ ]]; then
            continue
        else
            if [ ! -d "${HOME}/${line}" ]; then
                mkdir -p "${HOME}/${line}" #2>/dev/null
            fi
        fi
    done < <(cat "${1}")
}

function _save_originals(){
    local originals=( ~/.bashrc ~/.config/aliases ~/.config/functions ~/.config/exports )
    for file in "${originals[@]}"; do
        if [ -f "${file}" ]; then
            mv "${file}" ~/.local/backup/
        fi
    done
}

function _make_links(){
    ln -s "${DOTDIR}"/bashrc ~/.bashrc
    ln -s "${DOTDIR}"/.shellcheckrc ~/.shellcheckrc
    ln -s "${DOTDIR}"/micro/settings.json ~/.config/micro/settings.json
    ln -s "${DOTDIR}"/micro/bindings.json ~/.config/micro/bindings.json
}

function _install_required_packages() {
    local listfile="${1}"
    apt update
    while read -r line; do
        apt install -y "${line}"
    done < "${listfile}"
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
        # shellcheck source=/dev/null
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
        apt-get update
        apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    fi
}

function _remaining_configs() {
    ./"$DOTDIR"/install/editors.sh
}

function _install_fonts() {
    [ -d ~/fonts ] || mkdir -p ~/./fonts
    cp "$DOTDIR"/fonts/* ~/.local/share/fonts
    fc-cache -fv
}

function main() {
    _install_fonts
    _save_originals
    _make_directories "${DOTDIR}"/lists/mkdirs.list
    _make_links
    _install_required_packages "${DOTDIR}"/lists/packages.list
    _install_docker
    _remaining_configs
    apt autoremove
    # shellcheck source=/dev/null
    . "${HOME}"/.bashrc
    echo Completed.
}

echo 'Please enter github username: '
read -r my_gh_username
echo 'Please enter email address: '
read -r my_email
export my_gh_username
export my_email


main
