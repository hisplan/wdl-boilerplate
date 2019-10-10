#!/bin/bash

usage()
{
cat << EOF
USAGE: `basename $0` [options]
    -k  service account key (e.g. secrets.json)
EOF
}

while getopts "k:h" OPTION
do
    case $OPTION in
        k) service_account_key=$OPTARG ;;
        h) usage; exit 1 ;;
        *) usage; exit 1 ;;
    esac
done

if [ -z "$service_account_key" ]
then
    usage
    exit 1
fi

rm -rf Main.deps.zip
zip Main.deps.zip modules modules/*

cromwell-tools submit \
    --secrets-file ${service_account_key} \
    --wdl Main.wdl \
    --inputs-files Main.inputs.json \
    --deps-file Main.deps.zip \
    --label-file Main.labels.json \
    --options-file Main.options.json
