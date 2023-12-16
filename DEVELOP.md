# Develop

This is the full guide of how to start develop with this plugin.

Just install [requirements](#requirements) tools and make sure it work. The rest is pretty simple cause i have writed automation script to build and release. Yay.

## Table of Contents
  - [Requirements](#requirements)
  - [Project Structure](#project-structure)
  - [Workflow](#workflow)
  - [Scripts](#scripts)
    - [Android](#android-scripts)
    - [iOS](#ios-scripts)

## Requirements

> Android Plugin

- Android Studio (prefer latest) & related sdk ([Download](https://developer.android.com))
- Java 17

> iOS Plugin

- XCode (prefer latest)
- Python 3.x - ([Install](https://docs.python-guide.org/starting/install3/osx/))
- Scon ([Install](https://scons.org/doc/production/HTML/scons-user/ch01s02.html))


## Project Structure

```
.
└── root/
    ├── android/        - Android plugin
    ├── ios/            - iOS plugin
    ├── autoload/       - Autoload file to load Singleton plugin
    ├── scripts/        - Scripts to install, build, release for Android/iOS
    ├── example/        - Example of how to use the plugin
    ├── .cache/         - Cache folder to download building templates, headers
    ├── .release/       - When release a plugin, it will be here
    └── build.env       - Plugin build enviroment
```

## Workflow

### Android

Make sure you have opened the example (Godot 3 or 4 base on your prefer). Install Android Custom Template (So there will be `android/plugins` folder)

Coding android plugin in `./android` folder

Then run:

```sh
./scripts/android/build <version>
```

The plugin will build and also copy to the example, and you are ready to test it :)

(Remember the check if the plugin is checked in exported preset)

### iOS

Coding iOS plugin in `./ios` folder

Then run:

```sh
./scripts/android/build <version>
```

The plugin will build and also copy to the example, just export the ios project (make sure to check the plugin in export preset)

And done, everything is ready to test :)

## Scripts

### Android Scripts

> [install.sh](./scripts/android/install.sh)

Install godot-lib.aar, which require to build Android plugin.

(Will install default version in [build.env](./build.env) if no version provided)

Example:

```sh
./scripts/android/install.sh 3.5
```

> [build.sh](./scripts/android/build.sh)

Install and build the Android plugin

This will also copy builded file to the example projects (if you have install android custom template)

(Will build default version in [build.env](./build.env) if no version provided)

Example:

```sh
./scripts/android/build.sh 3.5
```

> [release.sh](./scripts/android/release.sh)

Build and release an Android plugin, the output will be in `.release/android/` folder.

(Will build and release all support versions in [build.env](./build.env) if no version provided)

Example:

```sh
# Release a specific version
./scripts/android/release.sh 3.5

# Release all version
./scripts/android/release.sh
```

### iOS Scripts

> [install.sh](./scripts/ios/install.sh)

Install godot extracted headers, which require to build iOS plugin.

(Will install default version in [build.env](./build.env) if no version provided)

Example:

```sh
./scripts/ios/install.sh 3.5
```

> [build.sh](./scripts/ios/build.sh)

Install and build the iOS plugin

This will also copy builded file to the example projects has exported ios project to `exported/ios`)

(Will build default version in [build.env](./build.env) if no version provided)

Example:

```sh
./scripts/ios/build.sh 3.5
```

> [release.sh](./scripts/ios/release.sh)

Build and release an iOS plugin, the output will be in `.release/ios/` folder.

(Will build and release all support versions in [build.env](./build.env) if no version provided)

Example:

```sh
# Release a specific version
./scripts/ios/release.sh 3.5

# Release all version
./scripts/ios/release.sh
```