#!/bin/sh

AddTag(){
ls -R
java -version
    if [ -z "$DBM_PASSWORD" ]
    then
      echo "Using global password variable"
      DBM_PWD=$DBMAESTRO_PASSWORD
    else
      echo "Using local password variable"
      DBM_PWD=$DBM_PASSWORD
    fi
    if [ -z "$DBM_PASSWORD" ]
        then
          echo "Using global password variable"
          DBM_PWD=$DBMAESTRO_PASSWORD
        else
          echo "Using local password variable"
          DBM_PWD=$DBM_PASSWORD
        fi
    CMDLINE='java -jar "'$DBM_TOOL_PATH'/DBmaestroAgent.jar" -AddTag -ProjectName "'$DBM_PROJECT_NAME'" -PackageName "'$DBM_PACKAGE_NAME'" -TagTypeName "'$DBM_TAG_TYPE_NAME'" -TagName "'$DBM_TAG_NAME'"'
    if [[  -n ${OBJ_TYPE_NAME} &&  -n ${OBJ_NAME} ]]; then
        CMDLINE=$CMDLINE'-ObjectTypeName "'$OBJ_TYPE_NAME'" -ObjectName "'$OBJ_NAME'"'
    fi
    CMDLINE=$CMDLINE' -Server "'$DBM_SERVER_ADDRESS'" -AuthType "'$DBM_AUTH_TYPE'" -UserName "'$DBM_USERNAME'" -Password "'$DBM_PWD'"'
    "$CMDLINE"
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    AddTag
fi