#!/bin/sh

node-gyp rebuild -j 2
. prebuild/Linux/bundle.sh
cp -a /data/build/. /data/output/

apt-get -y remove libcairo2-dev libpango1.0-dev libjpeg-dev libgif-dev librsvg2-dev
apt-get -y autoremove
npm test
# cd /root/harfbuzz-* && make uninstall
# cd /root/cairo-* && make uninstall
# cd /root/pango-* && make uninstall
# cd /root/libpng-* && make uninstall
# cd /root/libjpeg-* && make uninstall
# cd /root/giflib-* && make uninstall
# cd /data && npm test
