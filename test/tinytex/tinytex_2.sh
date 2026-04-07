#!/bin/bash

set -e

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

# Feature-specific tests
check "check pdflatex version" bash -c "pdflatex --version"

# Report result
reportResults
