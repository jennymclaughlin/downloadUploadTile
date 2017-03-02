#!/bin/bash
set -e

## Parameters
## Token from https://network.pivotal.io edit profile->generate token
## Local File - file name of tile from network.pivotal.io
## Download URL - location of download URL from network.pivotal.io

export PIVNET_TOKEN=$1
export LOCAL_FILE_NAME=$2
export DOWNLOAD_URL=$3

echo "Attempting download of $LOCAL_FILE_NAME from $DOWNLOAD_URL"
wget -O "$LOCAL_FILE_NAME" --post-data="" --header="Authorization: Token $PIVNET_TOKEN" $DOWNLOAD_URL
