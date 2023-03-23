#!/bin/bash
# shellcheck disable=SC1091,SC2174,SC2016

set -Eeuo pipefail

. /etc/environment

printf "\n\t🐋 Installing NVM tools 🐋\t\n"
VERSION=$(curl -s https://api.github.com/repos/nvm-sh/nvm/releases/latest | jq -r '.tag_name')
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$VERSION/install.sh" | bash
export NVM_DIR=$HOME/.nvm
echo "NVM_DIR=$HOME/.nvm" | tee -a /etc/environment

# Expressions don't expand in single quotes, use double quotes for that.shellcheck(SC2016)
# shellcheck disable=SC2016
echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' | tee -a /etc/skel/.bash_profile

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

printf "\n\t🐋 Installed NVM 🐋\t\n"
nvm --version

# node 12 and 16 are installed already in act-*
versions=("14")

printf "\n\t🐋 Installing METAGEN 🐋\t\n"
npm install -g https://github.com/kagekirin/metagen-js/tarball/main
which metagen
metagen --version
metagen --help

printf "\n\t🐋 Installing version tools 🐋\t\n"
npm install -g https://github.com/kagekirin/node-package-version/tarball/main
which node-package-version
node-package-version --version
node-package-version --help
npm install -g https://github.com/kagekirin/csproj-version/tarball/main
which csproj-version
csproj-version --version
csproj-version --help
npm install -g https://github.com/kagekirin/unity-bundle-version/tarball/main
which unity-bundle-version
unity-bundle-version --version
unity-bundle-version --help
npm install -g https://github.com/kagekirin/csproj-dependency-version/tarball/main
which csproj-dependency-version
csproj-dependency-version --version
csproj-dependency-version --help
