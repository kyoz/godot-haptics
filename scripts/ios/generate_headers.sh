#!/bin/bash

cd ./ios/godot

if [[ "$1" == "3.x" ]];
then
    ./../../scripts/ios/timeout scons platform=iphone target=release_debug
else
    ./../../scripts/ios/timeout scons platform=ios target=template_release  
fi