#!/bin/bash

get_android_template_file_name() {
    VERSION=$1

    if [ "${VERSION:0:1}" != "4" ]; then
        echo "godot-lib.${VERSION}.stable.release.aar"
    else
        echo "godot-lib.${VERSION}.stable.template_release.aar"
    fi
}

get_ios_template_file_name() {
    echo extracted_headers_godot_$1.zip
}

get_major_version() {
    VERSION=$1

    if [[ $VERSION =~ ^3\..* ]]; then
        echo $VERSION | sed -E 's/^([0-9]+)\..*$/\1.x/g'
    else
        echo "4.0"
    fi
}

get_example_path() {
    VERSION=$1

    if [[ $VERSION =~ ^3\..* ]]; then
        echo ./example/godot_3
    else
        echo ./example/godot_4
    fi
}