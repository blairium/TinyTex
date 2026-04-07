#!/bin/bash

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "check pdflatex version" bash -c "PATH=$PATH:$HOME/bin pdflatex --version"
check "check tlmgr version" bash -c "PATH=$PATH:$HOME/bin tlmgr --version"

# Report result
reportResults
