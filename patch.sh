#!/bin/bash
# https://github.com/deplives/OpenWrt-CI

for patchfile in $(ls -a patches); do
    if [ "${patchfile##*.}" == "patch" ]; then
        patch -p1 <patches/$patchfile
    fi
done
