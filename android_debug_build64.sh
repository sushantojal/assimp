cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug -DANDROID_ABI=arm64-v8a -DANDROID_NATIVE_API_LEVEL=android-24 -DANDROID_FORCE_ARM_BUILD=TRUE -DCMAKE_INSTALL_PREFIX=install -DANDROID_STL=gnustl_static -DANDROID_STL_FORCE_FEATURES=ON -DCMAKE_TOOLCHAIN_FILE=/home/nola.donato/android-sdks/ndk-bundle/build/cmake/android.toolchain.cmake -DANDROID_TOOLCHAIN=gcc
make

