#!/bin/bash

set -eu

source $(cd $(dirname $0) && pwd)/helpers.sh

travis_fold start build_pahole "Building pahole"

CWD=$(pwd)
REPO_PATH=$1
PAHOLE_ORIGIN=https://github.com/anakryiko/pahole.git

mkdir -p ${REPO_PATH}
cd ${REPO_PATH}
git init
git remote add origin ${PAHOLE_ORIGIN}
git fetch origin
git checkout cmake-fix-uapi-headers

mkdir -p build
cd build
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -D__LIB=lib ..
make -j$((4*$(nproc))) all
sudo make install

export LD_LIBRARY_PATH=${LD_LIBRARY_PATH:-}:/usr/local/lib
ldd $(which pahole)
pahole --version

travis_fold end build_pahole
