#!/bin/bash

BASE_PATH=$(dirname '$0')

while getopts "m:i:" arg; do
    case $arg in
        m)
            MR_MODULE="$OPTARG";;
        i)
            MR_ITEM="$OPTARG";;
    esac
done

if [[ ${MR_MODULE} == "" || ${MR_ITEM} == "" ]]; then
    echo "Usage: $0 [-m module] [-i item]"
    exit 1
fi

new_conf_path=${BASE_PATH}/task/${MR_MODULE}
if [[ ! -d ${new_conf_path} ]]; then
    mkdir ${new_conf_path}
fi

if [[ ! -f ${new_conf_path}/${MR_ITEM}.conf ]]; then
    cp ${BASE_PATH}/task/example/template.conf ${new_conf_path}/${MR_ITEM}.conf
fi

new_src_path=${BASE_PATH}/task/${MR_MODULE}/${MR_ITEM}/
if [[ ! -d ${new_src_path} ]]; then
    mkdir -p ${new_src_path}
fi

if [[ `ls -A ${new_src_path}` == "" ]]; then
    cp -r ${BASE_PATH}/task/example/template/* ${new_src_path}
fi
