#!/bin/bash -e
################################################################################
##  File:  googlecloud.sh
##  Desc:  Installs Google Cloud CLI
##         Must be run as non-root user after homebrew
##  Warning: Adds over 800MB to image
################################################################################

# Install GitHub Google Cloud CLI
printf "\n\t🐋 Installing Google Cloud 🐋\t\n"
apt-get update -y -qq
apt-get install -y apt-transport-https ca-certificates gnupg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
apt-get update  -y -qq
apt-get install -y google-cloud-cli
npm install -g google-artifactregistry-auth
printf "\n\t🐋 Installed Google Cloud 🐋\t\n"
