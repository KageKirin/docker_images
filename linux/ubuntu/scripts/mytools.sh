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

printf "\n\t🐋 Installing Google Cloud 🐋\t\n"
apt-get update -y -qq
apt-get install -y apt-transport-https ca-certificates gnupg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
apt-get update  -y -qq
apt-get install -y google-cloud-cli
npm install -g google-artifactregistry-auth

printf "\n\t🐋 Installing .NET 🐋\t\n"
# prerequisites for native build
# note: change libicu70 -> libicu71 as soon as available
apt-get install libc6  libgcc1  libgcc-s1  libgssapi-krb5-2  libicu-dev  libicu70  liblttng-ust1  libssl3  libstdc++6  libunwind8  zlib1g

curl -LO https://dotnet.microsoft.com/download/dotnet/scripts/v1/dotnet-install.sh
bash ./dotnet-install.sh --install-dir /opt/hostedtoolcache/dotnet --no-path --channel STS  # net 7.0
bash ./dotnet-install.sh --install-dir /opt/hostedtoolcache/dotnet --no-path --channel LTS  # net 6.0
rm ./dotnet-install.sh
export DOTNET_ROOT=/opt/hostedtoolcache/dotnet
export PATH=$PATH:$DOTNET_ROOT
{
  echo "DOTNET_ROOT=${DOTNET_ROOT}"
  echo "PATH=\$PATH:\$DOTNET_ROOT"
} | tee -a /etc/environment

which dotnet
dotnet --version
dotnet --info
#dotnet --list-sdks
#dotnet --list-runtimes
printf "\n\t🐋 Installed .NET 🐋\t\n"
