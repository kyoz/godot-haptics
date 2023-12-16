#!/bin/bash
set -e

source ./build.env
source ./scripts/utils.sh

PLUGIN=${PLUGIN_NAME}
CACHE_DIR=${IOS_CACHE_DIR}
BUILD_VERSION=$([ ! -z "$1" ] && echo $1 || echo ${DEFAULT_IOS_TEMPLATE})
BUILDED_FOLDER=ios/bin/release

echo ">> Install iOS template..."
./scripts/ios/install.sh $BUILD_VERSION

echo ">> Cleaning and preparing folders..."
rm -rf ios/bin
mkdir -p ios/bin
rm -rf ios/godot
mkdir -p ios/godot

echo ">> Preparing extracted header template..."
HEADER_FILE=$(get_ios_template_file_name $BUILD_VERSION)
unzip ${CACHE_DIR}/${HEADER_FILE} -d ./ios/

echo ">> Building..."
MAJOR_VERSION=$(get_major_version $BUILD_VERSION)

# Compile Plugin
./scripts/ios/generate_static_library.sh $PLUGIN release $MAJOR_VERSION
./scripts/ios/generate_static_library.sh $PLUGIN release_debug $MAJOR_VERSION
mv ./ios/bin/${PLUGIN}.release_debug.a ./ios/bin/${PLUGIN}.debug.a

# Move to release folder
rm -rf $BUILDED_FOLDER 
mkdir $BUILDED_FOLDER
rm -rf $BUILDED_FOLDER/${PLUGIN}
mkdir -p $BUILDED_FOLDER/${PLUGIN}

# Move Plugin
mv ./ios/bin/${PLUGIN}.{release,debug}.a $BUILDED_FOLDER/${PLUGIN}
cp ./ios/plugin/${PLUGIN}.gdip $BUILDED_FOLDER/${PLUGIN}

# Copy to example if possible (for faster development)

EXAMPLE_PATH=$(get_example_path $BUILD_VERSION)/ios/plugins
if [ -d $EXAMPLE_PATH ]
then
    echo ">> Copy plugin to example"
    rm -rf ${EXAMPLE_PATH}/${PLUGIN}
    cp -r $BUILDED_FOLDER/${PLUGIN} ${EXAMPLE_PATH}/${PLUGIN}
fi