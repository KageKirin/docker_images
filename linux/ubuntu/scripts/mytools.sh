#!/bin/bash
# shellcheck disable=SC1091,SC2174,SC2016

set -Eeuo pipefail

. /etc/environment

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
