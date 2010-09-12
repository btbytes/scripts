#!/bin/bash
#Source: http://stackoverflow.com/questions/2880434/how-to-install-pyside-v0-3-1-on-mac-os-x

BUILD_ROOT=~/tmp/pyside-build
INSTALL_PREFIX=~/tmp/pyside

function build_module {
    cd $BUILD_ROOT
    echo Cloning project $1 from url $2
    git clone --depth 1 $2 $BUILD_ROOT/$1

    BUILD_DIR=$BUILD_ROOT/$1/build
    mkdir -p $BUILD_DIR
    cd $BUILD_DIR

    echo Configuring $1 build.
    cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_PREFIX ..

    echo Configured $1. Starting build.
    make LD_LIBRARY_PATH=$INSTALL_PREFIX/lib

    echo Built $1. Installing.
    make install
    echo Successfully built and installed $1
}
