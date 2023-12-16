#!/bin/bash

echo "This will remove all cache, build, release example template files."
echo "Will save you lots of storage (>1GB to ~10MB)."
echo "But next build time, it will be slower."
read -p "Are you sure? (y/n)" -n 1 -r
echo 
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

echo ">> Removing all cache, build, release, example template files..."

# Cache
rm -rf .cache
rm -rf .release

# Android
rm -rf ./android/app/libs/*.aar

# iOS
rm -rf ./ios/bin
rm -rf ./ios/godot

# Example
rm -rf ./example/*/android
rm -rf ./example/*/exported/ios/*