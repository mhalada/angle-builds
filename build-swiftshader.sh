#!/bin/sh
set -e

cd swiftshader/build
cmake .. \
 -DCMAKE_BUILD_TYPE=Release \
 -DSWIFTSHADER_BUILD_EGL=TRUE \
 -DSWIFTSHADER_BUILD_GLESv2=TRUE \
 -DSWIFTSHADER_BUILD_PVR=FALSE \
 -DSWIFTSHADER_USE_GROUP_SOURCES=FALSE \
 -DSWIFTSHADER_BUILD_BENCHMARKS=FALSE \
 -DSWIFTSHADER_ENABLE_ASTC=FALSE \
 -DSWIFTSHADER_BUILD_TESTS=FALSE \
 -DSWIFTSHADER_BUILD_VULKAN=TRUE \
 -DSWIFTSHADER_BUILD_ANGLE=FALSE \
 -DWARNINGS_AS_ERRORS=FALSE
# -DSWIFTSHADER_WARNINGS_AS_ERRORS=FALSE

if [[ "$(uname)" == "Darwin" ]]; then
    NUM_JOBS=$(sysctl -n hw.physicalcpu)
else
    NUM_JOBS=$(nproc)
fi

cmake --build . --parallel $NUM_JOBS
