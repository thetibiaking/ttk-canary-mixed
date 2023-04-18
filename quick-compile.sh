#!/bin/sh

if [ -f "otbr" ]; then
  rm -rf otbr
fi

if [ -d "build" ]; then
  cd build
else
  mkdir build && cd build
fi

if [ -d "bin" ] || [ -d "CMakeFiles" ] ||  [ -d "src" ]; then
  make -j$(nproc) || exit 1
else
  cmake -DCMAKE_TOOLCHAIN_FILE=../../vcpkg/scripts/buildsystems/vcpkg.cmake ..
  make -j$(nproc) || exit 1
fi

if [ $? -eq 1 ]; then
  echo "Compilation failed!"
else
  cd bin && mv otbr ../../
  cd ../../
fi