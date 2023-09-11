#!/usr/bin/env bash
#######################  ts, Aug 12, 2023 at 3:53 AM  ##########################

# Full path of the current script
THIS_SCRIPT=$(readlink -f "${BASH_SOURCE[0]}" 2>/dev/null||echo $0)

# The directory where current script resides
SCRIPTDIR=$(dirname "${THIS_SCRIPT}")

# 'Dot' means 'source', i.e. 'include':
#. "$DIR/utils.sh"

# Setup DOTDIR and export env vars

# Make XDG and other common dirs

# Link shell's main rc files (.bashrc, aliases, ...)

# Link supplemental rc files (editor, terminal, ...)

# Install listed common packages through apt

