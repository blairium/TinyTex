#!/usr/bin/env bash
#-------------------------------------------------------------------------------------------------------------
# All code in this repository and TinyTeX are licensed under GPL-2. Per copying conditions of TeX Live, we (TinyTeX authors) want to clarify that:

# We did not make changes to the TeX Live distribution, but basically packaged up a subset of its packages and redistributed them as TinyTeX.

# We do not claim copyright on TinyTeX. Again, TinyTeX is a subset of TeX Live (https://tug.org/texlive/), and TeX Live is developed as a joint effort by all TeX user groups.

# Note that TinyTeX does not bundle the source code of LaTeX packages (to keep the size small). If you do want to obtain the source, you may find them on CTAN. Alternatively, you can reinstall a package with the command tlmgr install --reinstall --with-src <PKG> to obtain the source.
#-------------------------------------------------------------------------------------------------------------

#!/bin/bash

# --- CONFIGURATION ---
export TINYTEX_INSTALLER="${TINYTEX_INSTALLER:-TinyTeX-1}"


BIN_PATH="$HOME/bin"
SHELL_RC="$HOME/.bashrc"

echo "Starting TinyTeX setup..."

# 1. Install Dependencies
# These are required for Perl and SSL communication via tlmgr
echo "Checking system dependencies..."
apt update
apt install -y wget ghostscript dvipng

# 2. Execute Installation
# We use the -s prefix to the installer to ensure it's a "silent" but standard install
echo "Downloading and installing TinyTeX..."
wget -qO- "https://tinytex.yihui.org/install-bin-unix.sh" | sh


# 4. Update .bashrc
PATH_LINE="export PATH=\"\$PATH:$BIN_PATH\""

if ! grep -qF "$BIN_PATH" "$SHELL_RC"; then
    echo "Updating $SHELL_RC..."
    echo "" >> "$SHELL_RC"
    echo "# TinyTeX" >> "$SHELL_RC"
    echo "$PATH_LINE" >> "$SHELL_RC"
    echo "Path successfully added to $SHELL_RC."
else
    echo "TinyTeX path is already configured in $SHELL_RC."
fi

# 5. Finalize Session
export PATH="$PATH:$BIN_PATH"

echo "--- Verification ---"
if command -v tlmgr &> /dev/null; then
    echo "TinyTeX is ready to use."
    tlmgr --version 
else
    echo "Installation finished, but 'tlmgr' is not reachable in the current subshell."
    echo "Try running: source $SHELL_RC"
fi
