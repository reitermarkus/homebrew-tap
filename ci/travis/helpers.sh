#!/usr/bin/env bash
#
# helpers.sh
#
# Helper functions for Travis build scripts.
#

# force strict error checking
set -o errexit
set -o pipefail

# enable extended globbing syntax
shopt -s extglob

CYAN='\033[0;36m'
MAGENTA='\033[1;35m'
NC='\033[0m' # no color

# log command before running and add a blank line
run () {
  echo -e "${MAGENTA}>>>${NC} $*"
  eval "$*"
  local retval=$?
  echo
  return $retval
}

# print args as a cyan header
header () {
  echo
  echo -e "${CYAN}$*${NC}"
  echo
}

modified_cask_files () {
  if [[ -z "${MODIFIED_CASK_FILES+defined}" ]]; then
    MODIFIED_CASK_FILES="$(git diff --name-only --diff-filter=AM "${TRAVIS_COMMIT_RANGE}" -- Casks/*.rb)"
    export MODIFIED_CASK_FILES
  fi
  echo "${MODIFIED_CASK_FILES}"
}

modified_files_outside_casks () {
  if [[ -z "${MODIFIED_FILES_OUTSIDE_CASKS+defined}" ]]; then
    MODIFIED_FILES_OUTSIDE_CASKS="$(git diff --name-only "${TRAVIS_COMMIT_RANGE}" -- !(Casks))"
    export MODIFIED_FILES_OUTSIDE_CASKS
  fi
  echo "${MODIFIED_FILES_OUTSIDE_CASKS}"
}

any_casks_modified () {
  [[ -n "$(modified_cask_files)" ]]
}

must_run_tests () {
  [[ -n "$(modified_files_outside_casks)" ]]
}
