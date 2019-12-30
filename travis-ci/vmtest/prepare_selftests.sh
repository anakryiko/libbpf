#!/bin/sh

set -eux

LIBBPF_PATH=$(pwd)
REPO_PATH=$1

BPF_NEXT_ORIGIN=https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
LINUX_SHA=$(cat ${LIBBPF_PATH}/CHECKPOINT-COMMIT)

echo REPO_PATH = ${REPO_PATH}
echo LINUX_SHA = ${LINUX_SHA}

if [ ! -d "${REPO_PATH}" ]; then
	mkdir -p ${REPO_PATH}
	cd ${REPO_PATH}
	git init
	git remote add bpf-next ${BPF_NEXT_ORIGIN}
	git fetch --depth 1 bpf-next ${LINUX_SHA}
	git reset --hard ${LINUX_SHA}
else
	cd ${REPO_PATH}
fi

make CLANG=clang-10 LLC=llc-10 -C tools/testing/selftests/bpf -j $((4*$(nproc)))

mkdir ${LIBBPF_PATH}/selftests
cp -R tools/testing/selftests/bpf ${LIBBPF_PATH}/selftests
cd ${LIBBPF_PATH}
rm selftests/bpf/.gitignore
git add selftests

ldd selftests/bpf/test_progs
