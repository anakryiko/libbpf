#!/bin/sh

set -eux

cd libbpf/selftests/bpf

find /lib64/ -name 'libelf*'
ldd ./test_progs

echo TEST_PROGS
./test_progs
echo TEST_MAPS
./test_maps
echo TEST_VERIFIER
./test_verifier


