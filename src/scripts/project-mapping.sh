#!/bin/bash

ProjectMapping(){
    if [ -z "$DBM_PASSWORD" ]
    then
      echo "Using global password variable"
      DBM_PWD=$DBMAESTRO_PASSWORD
    else
      echo "Using local password variable"
      DBM_PWD=$DBM_PASSWORD
    fi
    CMDLINE='java -jar "'$DBM_TOOL_PATH'/DBmaestroAgent.jar" -ProjectMapping -ProjectName "'$DBM_PROJECT_NAME'" -TargetProjectName "'$DBM_TARGET_PROJECT_NAME'"'
    if [[  -n ${DBM_SCHEMA_MAP} ]]; then
        CMDLINE=$CMDLINE'-SchemaMap "'$DBM_SCHEMA_MAP' "'
    fi
    if [[  -n ${DBM_TRANSFER_OPENED_PACKAGE} ]]; then
        CMDLINE=$CMDLINE'-TransferOpenedPackage "'$DBM_TRANSFER_OPENED_PACKAGE' "'
    fi
    if [[  -n ${DBM_KEEP_STATE} ]]; then
        CMDLINE=$CMDLINE'-KeepState "'$DBM_KEEP_STATE' "'
    fi
    CMDLINE=$CMDLINE' -Server "'$DBM_SERVER_ADDRESS'" -AuthType "'$DBM_AUTH_TYPE'" -UserName "'$DBM_USERNAME'" -Password "'$DBM_PWD'"'
    eval "$CMDLINE"
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    ProjectMapping
fi