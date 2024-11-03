FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -qq update && apt-get -yq install build-essential curl git

COPY . /data
WORKDIR /data

# Set up Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
RUN apt-get -y install nodejs=18.5.0-1nodesource1

RUN npm install -g node-gyp
RUN npm install --ignore-scripts
RUN . prebuild/Linux/preinstall.sh
RUN cp prebuild/Linux/binding.gyp binding.gyp

CMD ["./build.sh"]
