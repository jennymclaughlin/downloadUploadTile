#!/bin/bash
set -e

## Parameters
## Local File - file name of tile after downloading from network.pivotal.io
## Opsmgr user - created during install of opsmgr
## OpsMgr password - used for upload into opsmgr

export LOCAL_FILE_NAME=$1
export OPSMGR_HOST=localhost
export OPSMGR_USER=$2
export OPSMGR_PASSWORD=$3

export BUNDLE_GEMFILE=/home/tempest-web/tempest/web/vendor/uaac/Gemfile

echo "Getting Ops Manager access token"
bundle exec uaac target "https://${OPSMGR_HOST}/uaa" --skip-ssl-validation
bundle exec uaac token owner get opsman ${OPSMGR_USER} -p "${OPSMGR_PASSWORD}" -s ""
OPSMGRTOKEN=`bundle exec uaac context | grep access_token | awk '{print $2}'`

echo "Attempting to upload of $LOCAL_FILE_NAME to $OPSMGR_HOST"
curl "https://${OPSMGR_HOST}/api/v0/available_products" -F "product[file]=@${LOCAL_FILE_NAME}" -X POST -H "Authorization: Bearer ${OPSMGRTOKEN}"  -k

echo "$LOCAL_FILE_NAME finished uploading to Ops Manager"

