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
    CMDLINE='java -jar "'$DBM_TOOL_PATH'/DBmaestroAgent.jar" -GetLatest -ProjectName "'$DBM_PROJECT_NAME'" -EnvName "'$DBM_ENVIRONMENT_NAME'"'
    if [[  -n ${DBM_PACKAGE_NAME} ]]; then
        CMDLINE=$CMDLINE'-PackageName "'$DBM_PACKAGE_NAME' "'
    fi
    if [[  -n ${DBM_LABEL_NAME} ]]; then
        CMDLINE=$CMDLINE'-LabelName "'$DBM_LABEL_NAME' "'
    fi
    if [[  -n ${DBM_BASELINE_LABEL_NAME} ]]; then
        CMDLINE=$CMDLINE'-BaselineLabelName "'$DBM_BASELINE_LABEL_NAME' "'
    fi
    if [[  -n ${DBM_CREATE_DCRIPTS_ONLY} ]]; then
        CMDLINE=$CMDLINE'-CreateScriptsOnly "'$DBM_CREATE_DCRIPTS_ONLY' "'
    fi
    CMDLINE=$CMDLINE' -Server "'$DBM_SERVER_ADDRESS'" -AuthType "'$DBM_AUTH_TYPE'" -UserName "'$DBM_USERNAME'" -Password "'$DBM_PWD'"'
    "$CMDLINE"
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    Greet
fi