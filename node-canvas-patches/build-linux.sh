#!/bin/sh

node-gyp rebuild -j 2
. prebuild/Linux/bundle.sh
