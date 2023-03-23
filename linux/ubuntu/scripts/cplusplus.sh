#!/bin/bash -e
################################################################################
##  File:  cplusplus.sh
##  Desc:  Installs C++ environment
##         Must be run as non-root user after homebrew
################################################################################

# Install Clang
printf "\n\t🐋 Installing Clang 🐋\t\n"
wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add -
add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu `lsb_release -sc` main universe restricted multiverse"
add-apt-repository -y "deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-16 main"
bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
apt-get install -y clang-format clang-tidy clang-tools clang clangd cmake
printf "\n\t🐋 Installed Clang 🐋\t\n"

# Install Ninja
printf "\n\t🐋 Installing Ninja 🐋\t\n"
curl -LO https://github.com/ninja-build/ninja/releases/download/v1.10.2/ninja-linux.zip
unzip -d /opt/hostedtoolcache/ninja ninja-linux.zip
rm ninja-linux.zip
export NINJA_HOME=/opt/hostedtoolcache/ninja
export PATH=$PATH:$NINJA_HOME
{
  echo "NINJA_HOME=${NINJA_HOME}"
  echo "PATH=\$PATH:\$NINJA_HOME"
} | tee -a /etc/environment
ninja --version
printf "\n\t🐋 Installed Ninja 🐋\t\n"
