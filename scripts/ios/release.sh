#!/usr/bin/env bash
set -e

source ./build.env
source ./scripts/utils.sh

PLUGIN=${PLUGIN_NAME}
CACHE_DIR=${IOS_CACHE_DIR}
BUILD_VERSIONS=($([ ! -z "$1" ] && echo $1 || echo ${IOS_TEMPLATES[@]}))
BUILDED_FOLDER=ios/bin/release
RELEASE_FOLDER=.release/ios

echo ">> Init release folder..."
mkdir -p $RELEASE_FOLDER

# Build template for all versions (or provided version)
for version in "${BUILD_VERSIONS[@]}"; do
    echo ">> Building ios template version: $version"

    echo ">> Install iOS template..."
    ./scripts/ios/install.sh $version

    echo ">> Cleaning and preparing folders..."
    rm -rf ios/bin
    mkdir -p ios/bin
    rm -rf ios/godot
    mkdir -p ios/godot

    echo ">> Preparing extracted header template..."
    HEADER_FILE=$(get_ios_template_file_name $version)
    unzip ${CACHE_DIR}/${HEADER_FILE} -d ./ios/

    echo ">> Building..."
    MAJOR_VERSION=$(get_major_version $version)

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

    # Pack the plugin to zip file
    cd $BUILDED_FOLDER
    zip -r $PLUGIN.zip haptics/
    cd ../../..

    mv $BUILDED_FOLDER/$PLUGIN.zip $RELEASE_FOLDER/ios-template-${version}.zip
done