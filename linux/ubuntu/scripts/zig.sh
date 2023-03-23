#!/bin/bash -e
################################################################################
##  File:  zig.sh
##  Desc:  Installs Zig
##         Must be run as non-root user after homebrew
################################################################################

# Install Zig
printf "\n\t🐋 Installing Zig 🐋\t\n"
curl -LO https://ziglang.org/builds/zig-linux-x86_64-0.11.0-dev.2232+84b89d7cf.tar.xz
tar xf zig-linux-x86_64-0.11.0-dev.2232+84b89d7cf.tar.xz
mv zig-linux-x86_64-0.11.0-dev.2232+84b89d7cf /opt/hostedtoolcache/zig
rm zig-linux-x86_64-0.11.0-dev.2232+84b89d7cf.tar.xz
export ZIG_HOME=/opt/hostedtoolcache/zig
export PATH=$PATH:$ZIG_HOME
{
  echo "ZIG_HOME=${ZIG_HOME}"
  echo "PATH=\$PATH:\$ZIG_HOME"
} | tee -a /etc/environment
zig version
#zig targets
printf "\n\t🐋 Installed Zig 🐋\t\n"
