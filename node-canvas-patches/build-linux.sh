#!/bin/sh

node-gyp rebuild -j 2
. prebuild/Linux/bundle.sh
cp -a build/. output/

apt-get remove packagename libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev
apt-get autoremove
npm test
