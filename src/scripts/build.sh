#!/bin/bash

Build(){
    if [ -z "$DBM_PASSWORD" ]
    then
      echo "Using global password variable"
      DBM_PWD=$DBMAESTRO_PASSWORD
    else
      echo "Using local password variable"
      DBM_PWD=$DBM_PASSWORD
    fi
    CMDLINE='java -jar "'$DBM_TOOL_PATH'/DBmaestroAgent.jar" -Build -ProjectName "'$DBM_PROJECT_NAME'" -EnvName "'$DBM_ENVIRONMENT_NAME'"'
    if [[  -n ${DBM_VERSION_TYPE} ]]; then
        CMDLINE=$CMDLINE'-VersionType "'$DBM_VERSION_TYPE' "'
    fi
    if [[  -n ${DBM_LABEL_NAME} ]]; then
        CMDLINE=$CMDLINE'-LabelName "'$DBM_LABEL_NAME' "'
    fi
    if [[  -n ${DBM_BASELINE_LABEL_NAME} ]]; then
        CMDLINE=$CMDLINE'-BaselineLabelName "'$DBM_BASELINE_LABEL_NAME' "'
    fi
    if [[  -n ${DBM_PACKAGE_NAME} ]]; then
        CMDLINE=$CMDLINE'-CreatePackage -PackageName "'$DBM_PACKAGE_NAME' "'
    fi
    if [[  -n ${DBM_VERSION_LEVEL} ]]; then
        CMDLINE=$CMDLINE'-CreatePackage -VersionLevel "'$DBM_VERSION_LEVEL' -AfterCurrentDeployedVersion "'$DBM_AFTER_CURRENT_DEPLOYED_VERSION' "'
    fi
    CMDLINE=$CMDLINE' -Server "'$DBM_SERVER_ADDRESS'" -AuthType "'$DBM_AUTH_TYPE'" -UserName "'$DBM_USERNAME'" -Password "'$DBM_PWD'"'
    "$CMDLINE"
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    Build
fi