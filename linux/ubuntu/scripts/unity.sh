#!/bin/bash -e
################################################################################
##  File:  unity.sh
##  Desc:  Installs Unity Editor and runtime
##         Must be run as non-root user after homebrew
################################################################################

CHANGESET='1b156197d683'
UNITY_VERSION='2021.3.21f1'
COMPONENTS='Unity,Linux-IL2CPP,Linux-Server,WebGL' #All

# Install Unity Editor
printf "\n\t🐋 Installing Unity 🐋\t\n"

curl -LO https://download.unity3d.com/download_unity/${CHANGESET}/UnitySetup-${UNITY_VERSION}
chmod +x UnitySetup-${UNITY_VERSION}
./UnitySetup-${UNITY_VERSION} --help
./UnitySetup-${UNITY_VERSION} --unattended --list-components
yes | ./UnitySetup-${UNITY_VERSION} --unattended --install-location=/opt/hostedtoolcache/unity --components=${COMPONENTS}

rm ./UnitySetup-${UNITY_VERSION}
export UNITY_HOME=/opt/hostedtoolcache/unity/Editor
export PATH=$PATH:$UNITY_HOME
{
  echo "UNITY_HOME=${UNITY_HOME}"
  echo "PATH=\$PATH:\$UNITY_HOME"
} | tee -a /etc/environment

printf "\n\t🐋 Installed Unity 🐋\t\n"
