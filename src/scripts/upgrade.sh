#!/bin/bash

Upgrade(){
    if [ -z "$DBM_PASSWORD" ]
    then
      echo "Using global password variable"
      DBM_PWD=$DBMAESTRO_PASSWORD
    else
      echo "Using local password variable"
      DBM_PWD=$DBM_PASSWORD
    fi
    CMDLINE='java -jar "'$DBM_TOOL_PATH'/DBmaestroAgent.jar" -Upgrade -ProjectName "'$DBM_PROJECT_NAME'" -EnvName "'$DBM_ENVIRONMENT_NAME'" -PackageName "'$DBM_PACKAGE_NAME'" '
    if [[  -n ${DBM_TAG_NAME} ]]; then
        CMDLINE=$CMDLINE'-TagName "'$DBM_TAG_NAME' "'
    fi
    if [[  -n ${DBM_BACKUP_BEHAVIOR} ]]; then
        CMDLINE=$CMDLINE'-BackupBehavior "'$DBM_BACKUP_BEHAVIOR' "'
    fi
    if [[  -n ${DBM_RESTORE_BEHAVIOR} ]]; then
        CMDLINE=$CMDLINE'-RestoreBehavior "'$DBM_RESTORE_BEHAVIOR' "'
    fi
    CMDLINE=$CMDLINE' -Server "'$DBM_SERVER_ADDRESS'" -AuthType "'$DBM_AUTH_TYPE'" -UserName "'$DBM_USERNAME'" -Password "'$DBM_PWD'"'
    eval "$CMDLINE"
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    Upgrade
fi