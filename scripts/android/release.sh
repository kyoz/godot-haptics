#!/usr/bin/env bash
set -e

source ./build.env
source ./scripts/utils.sh

CACHE_DIR=${ANDROID_CACHE_DIR}
BUILD_VERSIONS=($([ ! -z "$1" ] && echo $1 || echo ${ANDROID_TEMPLATES[@]}))
AAR_OUTPUT_PATH=android/app/build/outputs/aar
RELEASE_FOLDER=.release/android

echo ">> Init release folder..."
mkdir -p $RELEASE_FOLDER

# Build template for all versions (or provided version)
for version in "${BUILD_VERSIONS[@]}"; do
    echo ">> Building android template version: $version"

    echo "- Cleaning..."
    rm -rf $AAR_OUTPUT_PATH/*

    echo "- Install Android template..."
    ./scripts/android/install.sh $version

    echo "- Preparing build template..."
    # Remove other templates
    find "android/app/libs" -name "*.aar" -type f -delete
    # Copy matching godot aar template
    AAR_FILE=$(get_android_template_file_name $version)
    cp ${CACHE_DIR}/${AAR_FILE} android/app/libs/${AAR_FILE}

    echo "- Building lib..."
    cd android
    ./gradlew assembleRelease
    cd ..

    echo ">> Release to zip file..."
    mv $AAR_OUTPUT_PATH/app-release.aar $AAR_OUTPUT_PATH/${PLUGIN_NAME}-release.aar
    zip -j $RELEASE_FOLDER/android-template-${version}.zip \
        $AAR_OUTPUT_PATH/${PLUGIN_NAME}-release.aar \
        android/${GDAP_FILE}
done
