#!/bin/bash
:
set -eux

LIBBPF_PATH=$(pwd)
source ${LIBBPF_PATH}/travis-ci/vmtest/checkout_latest_kernel.sh

cp ${LIBBPF_PATH}/travis-ci/vmtest/latest.config .config
make -j $((4*$(nproc))) olddefconfig all
