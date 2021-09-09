AddTag(){
    CMDLINE="java -jar \"$DBM_TOOL_PATH/DBmaestroAgent.jar\" -Validate -ProjectName \"$DBM_PROJECT_NAME\" -PackageName \"$DBM_PACKAGE_NAME\""
    if [[ ! -z ${OBJ_TYPE_NAME} && ! -z ${OBJ_NAME} ]]; then
        CMDLINE=$CMDLINE"-ObjectTypeName \"$OBJ_TYPE_NAME\" -ObjectName \"$OBJ_NAME\""
    fi
    CMDLINE=$CMDLINE" -Server \"$DBM_SERVER_ADDRESS\" -AuthType \"$DBM_AUTH_TYPE\" -UserName \"$DBM_USERNAME\" -Password \"$DBM_PASSWORD\""
    $CMDLINE
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    Greet
fi