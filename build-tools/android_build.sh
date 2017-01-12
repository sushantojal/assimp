#!/bin/bash

# Points to a standalone Android toolchain
# See https://developer.android.com/ndk/guides/standalone_toolchain.html
# and http://www.myandroidonline.com/2015/06/09/compile-assimp-open-source-library-for-android/
# ANDROID_NDK=<path-to>/android-ndk-r10e
#export ANDROID_NDK=

# Points to the Android SDK
# ANDROID_SDK=<path-to>/sdk
#export ANDROID_SDK=

if [ -z "$ANDROID_NDK" ] || [ -z "$ANDROID_SDK" ]; then
  echo "Please specify ANDROID_SDK and ANDROID_NDK. Example:"
  echo "  export ANDROID_SDK=<path-to>/android-sdks"
  echo "  export ANDROID_NDK=<path-to>/android-ndk-r10e"
  exit 1
fi

# Directory of the script
pushd `dirname $0` > /dev/null
SCRIPT_PATH=`pwd -P`
popd > /dev/null

# This file must be downloaded from the android-cmake project on github:
# https://github.com/taka-no-me/android-cmake](https://github.com/taka-no-me/android-cmake
export ANDTOOLCHAIN=$SCRIPT_PATH/android-cmake/android.toolchain.cmake

echo $ANDTOOLCHAIN

# Do not touch these
export PATH=$PATH:$ANDROID_SDK/tools
export PATH=$PATH:$ANDROID_SDK/platform-tools
export PATH=$PATH:$ANDROID_SDK/android-toolchain/bin

# Two targets
# arm64-v8a
# armeabi-v7a with NEON

# Add additional args here as appropriate
cmake -DCMAKE_TOOLCHAIN_FILE=$ANDTOOLCHAIN \
      -DANDROID_NDK=$ANDROID_NDK \
      -DCMAKE_BUILD_TYPE=Release \
      -DANDROID_ABI="arm64-v8a" \
      -DANDROID_NATIVE_API_LEVEL=android-21 \
      -DANDROID_FORCE_ARM_BUILD=TRUE \
      -DCMAKE_INSTALL_PREFIX=install \
      ..

# This is to remove the versioned shared libs in assimp.
# Might be useful for other CMake-based projects, otherwise remove this line.
sed -i s/-soname,libassimp.so.3/-soname,libassimp.so/g code/CMakeFiles/assimp.dir/link.txt

make -j
make install
