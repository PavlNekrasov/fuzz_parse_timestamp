#!/bin/bash

SYSTEMD_DIR="/home/fuzz/systemd"
BUILD_DIR="$SYSTEMD_DIR/build-libfuzz"
SOURCE_FILE="fuzzer.c"

cd "$SYSTEMD_DIR"

CC=clang CXX=clang++ meson setup "$BUILD_DIR" -Dllvm-fuzz=true -Db_sanitize=address,undefined -Db_lundef=false

cd "$BUILD_DIR" && ninja

cd /home/fuzz
mkdir corpus


clang -fsanitize=fuzzer,address,undefined -g "$SOURCE_FILE" -o fuzz \
    -I "$SYSTEMD_DIR/src/basic/" -I "$SYSTEMD_DIR/src/fundamental/" -I "$BUILD_DIR/" \
    "$BUILD_DIR/src/basic/libbasic.a" "$BUILD_DIR/src/shared/libsystemd-shared-249.a"

