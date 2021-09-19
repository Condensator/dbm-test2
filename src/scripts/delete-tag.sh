#!/bin/bash

DeleteTag(){
    if [ -z "$DBMAESTRO_PASSWORD" ]
    then
      echo "DBMAESTRO_PASSWORD variable is not set"
      exit 1
    fi
    CMDLINE='java -jar "'$DBM_TOOL_PATH'/DBmaestroAgent.jar" -DeleteTag -ProjectName "'$DBM_PROJECT_NAME'" -PackageName "'$DBM_PACKAGE_NAME'" -TagTypeName "'$DBM_TAG_TYPE_NAME'" -TagName "'$DBM_TAG_NAME'" '
    if [[  -n ${OBJ_TYPE_NAME} &&  -n ${OBJ_NAME} ]]; then
        CMDLINE=$CMDLINE'-ObjectTypeName "'$OBJ_TYPE_NAME'" -ObjectName "'$OBJ_NAME'"'
    fi
    CMDLINE=$CMDLINE' -Server "'$DBM_SERVER_ADDRESS'" -AuthType "'$DBM_AUTH_TYPE'" -UserName "'$DBM_USERNAME'" -Password "'$DBMAESTRO_PASSWORD'"'
    eval "$CMDLINE"
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    DeleteTag
fi