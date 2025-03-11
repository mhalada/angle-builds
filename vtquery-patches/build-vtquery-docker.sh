#!/bin/sh

apt-get update && apt-get -y install build-essential curl

# Ubuntu 20.04
#   - /lib/aarch64-linux-gnu/libstdc++.so.6: version GLIBCXX_3.4.29' not found
#   - /lib/aarch64-linux-gnu/libc.so.6: version `GLIBC_2.32' not found
# export DEBIAN_FRONTEND=noninteractive
# apt-get -y install build-essential curl software-properties-common
# add-apt-repository ppa:ubuntu-toolchain-r/test -y
# apt-get update && apt-get install gcc-11 g++-11 -y

curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
apt-get install nodejs -y

cd vtquery
npm install
npm test
