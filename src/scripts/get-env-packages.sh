#!/bin/bash

GetEnvPackages(){
    if [ -z "$DBM_PASSWORD" ]
    then
      echo "Using global password variable"
      DBM_PWD=$DBMAESTRO_PASSWORD
    else
      echo "Using local password variable"
      DBM_PWD=$DBM_PASSWORD
    fi
    CMDLINE='java -jar "'$DBM_TOOL_PATH'/DBmaestroAgent.jar" -GetEnvPackages -ProjectName "'$DBM_PROJECT_NAME'" -EnvName "'$DBM_ENVIRONMENT_NAME'"'
    if [[  -n ${DBM_FROM_DATE} ]]; then
        CMDLINE=$CMDLINE'-FromDate "'$DBM_FROM_DATE' "'
    fi
    if [[  -n ${DBM_TO_DATE} ]]; then
        CMDLINE=$CMDLINE'-ToDate "'$DBM_TO_DATE' "'
    fi
    if [[  -n ${DBM_DATE_FORMAT} ]]; then
        CMDLINE=$CMDLINE'-DateFormat "'$DBM_DATE_FORMAT' "'
    fi
    if [[  -n ${DBM_FILE_PATH} ]]; then
        CMDLINE=$CMDLINE'-FilePath "'$DBM_FILE_PATH' "'
    fi
    CMDLINE=$CMDLINE' -Server "'$DBM_SERVER_ADDRESS'" -AuthType "'$DBM_AUTH_TYPE'" -UserName "'$DBM_USERNAME'" -Password "'$DBM_PWD'"'
    "$CMDLINE"
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    GetEnvPackages
fi