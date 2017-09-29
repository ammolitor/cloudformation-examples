#!/usr/bin/env bash

if [ $# -ne 1 ]; then echo "USAGE: ${0} [path/template-file.json]"; exit 1; fi

template=${1}
templatename=$(basename ${template})
region="us-east-1"
stackname=${templatename//.json/}
destination="ammolitor/cloudformation/${templatename}"
export AWS_DEFAULT_PROFILE=default

aws s3 cp ${template} s3://${destination}

aws cloudformation validate-template \
--region ${region} \
--template-url https://s3.amazonaws.com/${destination}