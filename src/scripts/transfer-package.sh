#!/bin/bash

TransferPackage(){
    if [ -z "$DBM_PASSWORD" ]
    then
      echo "Using global password variable"
      DBM_PWD=$DBMAESTRO_PASSWORD
    else
      echo "Using local password variable"
      DBM_PWD=$DBM_PASSWORD
    fi
    CMDLINE='java -jar "'$DBM_TOOL_PATH'/DBmaestroAgent.jar" -TransferPackage -ProjectName "'$DBM_PROJECT_NAME'" -TargetProjectName "'$DBM_TARGET_PROJECT_NAME'" -SourcePackage "'$DBM_SOURCE_PACKAGE'"'
    if [[  -n ${DBM_TARGET_PACKAGE} ]]; then
        CMDLINE=$CMDLINE' -TargetPackage "'$DBM_TARGET_PACKAGE' "'
    fi
    if [[  -n ${DBM_VERSION_LEVEL} ]]; then
        CMDLINE=$CMDLINE'-VersionLevel "'$DBM_VERSION_LEVEL' "'
    fi
    CMDLINE=$CMDLINE' -Server "'$DBM_SERVER_ADDRESS'" -AuthType "'$DBM_AUTH_TYPE'" -UserName "'$DBM_USERNAME'" -Password "'$DBM_PWD'"'
    eval "$CMDLINE"
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    TransferPackage
fi