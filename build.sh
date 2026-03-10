#! /usr/bin/env bash

build_type=Debug
build_dir=_build

if [ $build_type == "Debug" ]; then
    dest_dir=$HOME/tmp/ghaas-debug
else
    dest_dir=$CONDA_PREFIX
fi

cmake -B $build_dir --fresh -DCMAKE_BUILD_TYPE=$build_type -DCMAKE_INSTALL_PREFIX=$dest_dir
cmake --build $build_dir
ctest -V --test-dir $build_dir
cmake --install $build_dir --prefix $dest_dir

exit 0
