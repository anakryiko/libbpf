#!/bin/bash

set -eux

cd libbpf/selftests/bpf

echo TEST_PROGS
./test_progs ${BLACKLIST:+-b$BLACKLIST} ${WHITELIST:+-t$WHITELIST}
