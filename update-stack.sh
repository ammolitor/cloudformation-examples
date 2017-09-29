#!/usr/bin/env bash

if [ $# -ne 1 ]; then echo "USAGE: ${0} [path/template-file.json]"; exit 1; fi

template=${1}
templatename=$(basename ${template})
region="us-east-1"
stackname=${templatename//.json/}
destination="ammolitor/cloudformation/${templatename}"
export AWS_DEFAULT_PROFILE=default

aws s3 cp ${template} s3://${destination}

aws cloudformation update-stack \
--region ${region} \
--stack-name ${stackname} \
--template-url https://s3.amazonaws.com/${destination} \
--tags Key="Name",Value="${stackname}" Key="Owner",Value="Aaron Molitor" Key="Purpose",Value="DC/OS Testing" Key="Department",Value="" \
--capabilities CAPABILITY_NAMED_IAM