#!/bin/bash
#Source: http://stackoverflow.com/questions/2880434/how-to-install-pyside-v0-3-1-on-mac-os-x

BUILD_ROOT=~/tmp/pyside-build
INSTALL_PREFIX=/usr/local

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
    if $3       
        then
        make $3 LD_LIBRARY_PATH=$INSTALL_PREFIX/lib
    fi     
    echo Built $1. Installing.
    make install
    echo Successfully built and installed $1
}

rm -rf $BUILD_ROOT
mkdir -p $BUILD_ROOT
build_module apiextractor git://gitorious.org/pyside/apiextractor.git
build_module generatorrunner git://gitorious.org/pyside/generatorrunner.git
build_module shiboken git://gitorious.org/pyside/shiboken.git shiboken_generator
build_module pyside git://gitorious.org/pyside/pyside.git
