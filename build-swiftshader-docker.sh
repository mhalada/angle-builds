#!/bin/sh

apt-get update && apt-get -y install build-essential curl python3

curl -L -o /tmp/cmake.sh https://github.com/Kitware/CMake/releases/download/v3.30.2/cmake-3.30.2-linux-aarch64.sh
chmod +x /tmp/cmake.sh
/tmp/cmake.sh --skip-license --prefix=/usr
rm /tmp/cmake.sh

./build-swiftshader.sh