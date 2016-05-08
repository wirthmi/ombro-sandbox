#!/bin/sh

set -e

build_directory="`dirname "$0"`"
install_directory="`pwd`"

if uname -o | grep -i 'cygwin' > /dev/null; then
  install_directory="`cygpath -w "$install_directory"`"
fi

cd "$build_directory"

# at first configure
cmake ../ "$@" -DCMAKE_INSTALL_PREFIX="$install_directory"

# then build and install
make -j "`nproc`" install || cmake --build ./ --target install
