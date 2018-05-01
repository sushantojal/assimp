cmake -G "Unix Makefiles" -DANDROID_LINKER_FLAGS=-Wl,--exclude-libs,libunwind.a -DCMAKE_BUILD_TYPE=Release -DANDROID_ABI=arm64-v8a -DANDROID_NATIVE_API_LEVEL=android-24 -DANDROID_FORCE_ARM_BUILD=TRUE -DCMAKE_INSTALL_PREFIX=install -DANDROID_STL=c++_shared -DANDROID_STL_FORCE_FEATURES=ON -DCMAKE_TOOLCHAIN_FILE=$(NDK_BUNDLE)/build/cmake/android.toolchain.cmake -DANDROID_TOOLCHAIN=clang
make -j12
cd lib
cp libassimp.so libassimp.so.debug

$ANDROID_SDK/ndk-bundle/toolchains//aarch64-linux-android-4.9/prebuilt/linux-x86_64/aarch64-linux-android/bin/strip libassimp.so

