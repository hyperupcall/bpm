# shellcheck shell=bash

set -ETeo pipefail
shopt -s nullglob extglob

load 'vendor/bats-core/load.bash'
load 'vendor/bats-assert/load.bash'
load 'util/test_util.sh'

export LANG="C"
export LANGUAGE="C"
export LC_ALL="C"
export XDG_DATA_HOME=

# When doing tests
# Test-specific
export BPM_TEST_DIR="$BATS_TMPDIR/bpm"
export BPM_ORIGIN_DIR="$BPM_TEST_DIR/origin"
export BPM_IS_TEST=

# Stub common variables
test_util.get_repo_root
# The root of the real source. This is a separate variable because we want to
# set 'BPM_LOCAL_PROJECT_DIR' to some other value
export BPM_TEST_REPO_ROOT="$REPLY"
export PROGRAM_LIB_DIR="$BPM_TEST_REPO_ROOT/pkg/lib"

export BPM_LOCAL_PROJECT_DIR=
export BPM_REPO_SOURCE="$BPM_TEST_DIR/source"
export BPM_CELLAR="$BPM_TEST_DIR/cellar"
export BPM_PACKAGES_PATH="$BPM_CELLAR/packages"
export BPM_INSTALL_BIN="$BPM_CELLAR/bin"
export BPM_INSTALL_MAN="$BPM_CELLAR/man"
export BPM_INSTALL_COMPLETIONS="$BPM_CELLAR/completions"
export BPM_MODE='global' # for non-tests, the default is 'local'

export PATH="$BPM_TEST_REPO_ROOT/pkg/bin:$PATH"
source "$BPM_TEST_REPO_ROOT/pkg/lib/source/bpm-load.sh"
source "$BPM_TEST_REPO_ROOT/pkg/lib/cmd/bpm.sh"

for f in "$BPM_TEST_REPO_ROOT"/pkg/lib/{commands,commands-global,plumbing,util}/?*.sh; do
	source "$f"
done

bpm() {
	_cmd_.bpm "$@"
}

setup() {
	mkdir -p "$BPM_TEST_DIR" "$BPM_ORIGIN_DIR"
	cd "$BATS_TEST_TMPDIR"
}

teardown() {
	rm -rf "$BPM_TEST_DIR"
}
