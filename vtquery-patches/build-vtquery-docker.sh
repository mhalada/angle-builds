#!/bin/sh

apt-get update && apt-get -y install build-essential curl

curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
apt-get install nodejs -y

npm install
npm test
