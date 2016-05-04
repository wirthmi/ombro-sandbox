#!/bin/sh

set -e

build_directory="`dirname "$0"`"
install_directory="`pwd`"

cd "$build_directory"

# at first configure
cmake ../ "$@" -DCMAKE_INSTALL_PREFIX="$install_directory"

# then build and install
make -j "`nproc`" install || cmake --build ./ --target install
