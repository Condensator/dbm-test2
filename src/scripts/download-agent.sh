Download(){
export PARAM_DBM_TOOL_PATH = ${!PARAM_DBM_TOOL_PATH}
#Check if dbmaestroagent.jar already exists
if [ -f "${PARAM_DBM_TOOL_PATH}/DBmaestroAgent.jar" ]; then
    echo "${PARAM_DBM_TOOL_PATH}/DBmaestroAgent.jar already exists."
    exit 0
fi

# the directory of the script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# the temp directory used, within $DIR
# omit the -p parameter to create a temporal directory in the default location
DBM_TEMP=$(mktemp -d -p "$DIR")

# check if tmp dir was created
if [ ! -d "$DBM_TEMP" ]; then
  echo "Could not create temp dir"
  exit 1
fi

# deletes the temp directory
function cleanup {      
  rm -rf "$DBM_TEMP"
  echo "Deleted temp working directory $DBM_TEMP"
}

# register the cleanup function to be called on the EXIT signal
trap cleanup EXIT

# Download and unzip jar
wget https://dbmaestro.com/Downloads/DOP-X/Utilities/DBmaestroAgent.zip -O "$DBM_TEMP/DBmaestroAgent.zip"
echo "${PARAM_DBM_TOOL_PATH}"
mkdir "${PARAM_DBM_TOOL_PATH}"
unzip "$DBM_TEMP/DBmaestroAgent.zip" -d "${PARAM_DBM_TOOL_PATH}"
echo "Downlaod completed"
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
    Download
fi