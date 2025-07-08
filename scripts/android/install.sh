#!/bin/bash

source ./build.env
source ./scripts/utils.sh

CACHE_DIR=${ANDROID_CACHE_DIR}
SUPPORT_VERSIONS=(${ANDROID_TEMPLATES[@]})
VERSION=$([ ! -z "$1" ] && echo $1 || echo ${DEFAULT_ANDROID_TEMPLATE})

GODOT_AAR_URL="https://github.com/kyoz/godot-android-release-libs/releases/download/v1.0.0"

# Create .cache folder if not existed
if [ ! -d "${CACHE_DIR}" ]; then
    mkdir -p "${CACHE_DIR}"
fi

# Check if template version is support or not
if [[ ! " ${SUPPORT_VERSIONS[*]} " =~ " ${VERSION} " ]]; then
    echo "- Your template version is not supported yet :'("
    exit 1
fi

# Install template, will bypass cached templates
AAR_FILE=$(get_android_template_file_name $VERSION)

# Check if version is cached
if test -f "${CACHE_DIR}/${AAR_FILE}"; then
    echo "- Downloaded android template version ${VERSION} (cached)"
else
    echo "- Downloading android template version ${VERSION}..."
    #wget -P "${CACHE_DIR}" "${GODOT_AAR_URL}/${VERSION}/${AAR_FILE}"
    wget -P "${CACHE_DIR}" "${GODOT_AAR_URL}/${AAR_FILE}"
fi


