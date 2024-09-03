#!/bin/bash
set -e

cd swiftshader/build
cmake .. \
 -DCMAKE_BUILD_TYPE=Release \
 -DSWIFTSHADER_BUILD_EGL=FALSE \
 -DSWIFTSHADER_BUILD_GLESv2=FALSE \
 -DSWIFTSHADER_BUILD_PVR=FALSE \
 -DSWIFTSHADER_USE_GROUP_SOURCES=FALSE \
 -DSWIFTSHADER_BUILD_BENCHMARKS=FALSE \
 -DSWIFTSHADER_ENABLE_ASTC=FALSE \
 -DSWIFTSHADER_BUILD_TESTS=FALSE \
 -DSWIFTSHADER_BUILD_VULKAN=TRUE \
 -DSWIFTSHADER_BUILD_ANGLE=TRUE \
 -DWARNINGS_AS_ERRORS=FALSE

if [[ "$(uname)" == "Darwin" ]]; then
    NUM_JOBS=$(sysctl -n hw.physicalcpu)
else
    NUM_JOBS=$(nproc)
fi

cmake --build . --parallel $NUM_JOBS
