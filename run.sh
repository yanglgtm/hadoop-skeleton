#!/bin/bash
#================================================================
# Hadoop skeleton script by Jiang Yang <jiangyang33@gmail.com>
# https://mikej.me/
#================================================================


while getopts "m:i:d:g" arg; do
    case $arg in
        m)
            MR_MODULE="$OPTARG";;
        i)
            MR_ITEM="$OPTARG";;
        d)
            DEBUG=true;;
        g)
            GET_DATA=true
    esac
done

BASE_PATH=$(dirname '$0')

function usage()
{
    output=$1
    if [[ -z "${output}" ]]; then
        output="Usage: $0 [-m module] [-i item] [-d] [-g]"
    fi
    echo -e "\x1b[31m ${output} \x1b[0m"
    exit 1
}

function init()
{
    if [[ ${MR_MODULE} == "" || ${MR_ITEM} == "" || $1 == "--help" ]]; then
        usage
    fi

    conf_path=${BASE_PATH}/task/${MR_MODULE}/${MR_ITEM}.conf

    if [[ ! -f ${conf_path} ]]; then
        usage "no target file: "${conf_path}
    fi

    source ${conf_path}

    if [[ ${MR_JOBNAME} == "" \
        || ${MR_INPUT} == "" \
        || ${MR_OUTPUT} == "" \
        || ${MR_MAPPER} == "" \
        || ${MR_REDUCER} == "" ]]; then
        usage "MR_JOBNAME|MR_INPUT|MR_OUTPUT|MR_MAPPER|MR_REDUCER can not be null"
    fi

    source ${BASE_PATH}/main.conf
}

function main()
{
    param="
        -input ${MR_INPUT} \
        -output ${MR_OUTPUT} \
        -mapper \"${MR_MAPPER}\" \
        -reducer \"${MR_REDUCER}\" \
        ${MR_JOB_CONF} \
        ${MR_ATTACH_CONF} \
    "

    src_path=${BASE_PATH}/task/${MR_MODULE}/${MR_ITEM}
    if [[ -d ${src_path} ]]; then
        files=`ls ${src_path}`
        for file in ${files[@]}; do
            param=${param}" -file ${src_path}/${file}"
        done
    fi

    param=`echo ${param}`
    if [[ ${DEBUG} == true ]]; then
        usage "${param}"
    fi

    ${HADOOP_BIN} fs -rmr ${MR_OUTPUT}
    # https://stackoverflow.com/questions/6087494/bash-inserting-quotes-into-string-before-execution
    eval "${HADOOP_BIN} streaming ${param}"

    if [[ ${GET_DATA} == true ]]; then
        output_path=${BASE_PATH}/output/${MR_MODULE}-${MR_ITEM}
        if [[ -d ${output_path} ]]; then
            rm -rf ${output_path}/*
        else
            mkdir ${output_path}
        fi
        ${HADOOP_BIN} fs -get ${MR_OUTPUT}/* ${output_path}
        echo "The results have been downloaded to the directory: ${output_path}"
    fi
}

init
main
