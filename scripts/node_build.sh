#!/bin/bash

cd "$(dirname "$0")"
source ./vars.sh
cd ../lib/node

export CC="ccache gcc"
export CXX='ccache g++'
./configure --link-module './nbin.js' --link-module './lib/_third_party_main.js' --dest-cpu=x64
echo -e "travis_fold:start:$1\033[33;1m$2\033[0m"
make -j2
echo -e "\ntravis_fold:end:$1\r"
cd ../../

mkdir -p ./build/$PACKAGE_VERSION


if [[ "$OSTYPE" == "linux-gnu" ]]; then
	OS="linux"
elif [[ "$OSTYPE" == "darwin"* ]]; then
	OS="darwin"
fi

ARCH=$(uname -m)
BINARY_NAME="node-${NODE_VERSION}-${OS}-${ARCH}"

cp ./lib/node/out/Release/node ./build/$PACKAGE_VERSION/$BINARY_NAME
