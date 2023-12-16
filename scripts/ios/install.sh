#!/bin/bash

source ./build.env
source ./scripts/utils.sh

CACHE_DIR=${IOS_CACHE_DIR}
SUPPORT_VERSIONS=(${IOS_TEMPLATES[@]})
VERSION=$([ ! -z "$1" ] && echo $1 || echo ${DEFAULT_IOS_TEMPLATE})

GODOT_SOURCE_URL="https://github.com/kyoz/godot-ios-extracted-headers/releases/download/stable"

# Create .cache folder if not existed
if [ ! -d "${CACHE_DIR}" ]; then
    mkdir -p "${CACHE_DIR}"
fi

# Check if template version is support or not
if [[ ! " ${SUPPORT_VERSIONS[*]} " =~ " ${VERSION} " ]]; then
    echo "- Your template version is not supported yet :'("
    exit 1
fi

# Install godot extracted headers, will bypass cached ones
HEADER_FILE=$(get_ios_template_file_name $VERSION)

# Check if version is cached
if test -f "${CACHE_DIR}/${HEADER_FILE}"; then
    echo "- Downloaded godot extracted headers version ${VERSION} (cached)"
else
    echo "- Downloading godot extracted headers version ${VERSION}..."
    wget -P "${CACHE_DIR}" "${GODOT_SOURCE_URL}/${HEADER_FILE}"
fi