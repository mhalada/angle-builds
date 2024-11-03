FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -qq update && apt-get -yq install \
    apt-transport-https \
    build-essential \
    curl \
    g++ \
    gcc \
    git \
    pkg-config \
    unzip

COPY . /data

# Set up Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get -y install nodejs=18.5.0-1nodesource1

RUN npm install -g node-gyp \
  && npm install --ignore-scripts \
  && . prebuild/Linux/preinstall.sh \
  && cp prebuild/Linux/binding.gyp binding.gyp

WORKDIR /data
CMD ["./build.sh"]
