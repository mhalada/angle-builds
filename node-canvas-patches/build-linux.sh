#!/bin/sh

node-gyp rebuild -j 2
. prebuild/Linux/bundle.sh
cp -a /data/build/. /data/output/

cd /root/harfbuzz-* && make uninstall
cd /root/cairo-* && make uninstall
cd /root/pango-* && cd _build && ninja uninstall
cd /root/libpng-* && make uninstall
cd /root/libjpeg-* && cd b && make uninstall
cd /root/giflib-* && make uninstall

cd /data && npm test
