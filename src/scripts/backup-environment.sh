#!/bin/bash

BackupEnvironment(){
    if [ -z "$DBM_PASSWORD" ]
    then
      echo "Using global password variable"
      DBM_PWD=$DBMAESTRO_PASSWORD
    else
      echo "Using local password variable"
      DBM_PWD=$DBM_PASSWORD
    fi
    CMDLINE='java -jar "'$DBM_TOOL_PATH'/DBmaestroAgent.jar" -BackupEnvironment -ProjectName "'$DBM_PROJECT_NAME'" -EnvName "'$DBM_ENVIRONMENT_NAME'" -BackupName "'$DBM_BACKUP_NAME'" -IgnoreEnvVersionMismatch "'$DBM_IGNORE_ENV_VERSION_MISMATCH'"'
    if [[  -n ${DBM_BACKUP_DESCRIPTION} ]]; then
        CMDLINE=$CMDLINE' -BackupDescription "'$DBM_BACKUP_DESCRIPTION'"'
    fi
    CMDLINE=$CMDLINE' -Server "'$DBM_SERVER_ADDRESS'" -AuthType "'$DBM_AUTH_TYPE'" -UserName "'$DBM_USERNAME'" -Password "'$DBM_PWD'"'
    eval "$CMDLINE"
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    BackupEnvironment
fi