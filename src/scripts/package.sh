#!/bin/bash

Package(){
    if [ -z "$DBM_PASSWORD" ]
    then
      echo "Using global password variable"
      DBM_PWD=$DBMAESTRO_PASSWORD
    else
      echo "Using local password variable"
      DBM_PWD=$DBM_PASSWORD
    fi
    CMDLINE='java -jar "'$DBM_TOOL_PATH'/DBmaestroAgent.jar" -Package -ProjectName "'$DBM_PROJECT_NAME'" '
    if [[  -n ${DBM_IGNORE_SCRIPT_WARNINGS} ]]; then
        CMDLINE=$CMDLINE'-IgnoreScriptWarnings "'$DBM_IGNORE_SCRIPT_WARNINGS' "'
    fi
    if [[  -n ${DBM_FILE_PATH} ]]; then
        CMDLINE=$CMDLINE'-FilePath "'$DBM_FILE_PATH' "'
    fi
    CMDLINE=$CMDLINE' -Server "'$DBM_SERVER_ADDRESS'" -AuthType "'$DBM_AUTH_TYPE'" -UserName "'$DBM_USERNAME'" -Password "'$DBM_PWD'"'
    echo "$CMDLINE"
    eval "$CMDLINE"
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    Package
fi