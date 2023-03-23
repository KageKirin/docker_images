#!/bin/bash -e
################################################################################
##  File:  dotnet.sh
##  Desc:  Installs .NET CLI
##         Must be run as non-root user after homebrew
################################################################################

# Install .NET CLI
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
