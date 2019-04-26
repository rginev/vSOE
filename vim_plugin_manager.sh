#!/usr/bin/env bash
#
# Usage:
#  Add or remove Vim packages
#    Plugins on command line: vim_plugin_manager.sh add|remove PLUGIN1 ....
#    Plugins read from environmental variable: PLUGINS="PLUGIN1 PLUGIN2 ...." vim_plugin_manager.sh add|remove
#
#  Update Vim packages: vim_plugin_manager.sh update
#
# Examples:
#   vim_plugin_manager.sh scrooloose/nerdtree
#   PLUGINS="vim-airline/vim-airline tpope/vim-fugitive" vim_plugin_manager.sh
#
# Notes
#   - Script MUST be executed from repository top directory i.e. where .git and .gitmodules are
#   - TARGET_DIR defaults to a path relative to the directory from which this script is executed
#

# set -x
set -o pipefail

#------------------------------------------------------------
# Functions

usage() {
  echo -e "Usage:\n\t$0 {add|remove} Plugin1 [Plugin2 ...]"
  echo -e "\t$0 update"
  echo
}

err() { echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')][ERROR]: $@" >&2
  # kill -s TERM $TOP_PID
  exit 110
}

info() {
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')][INFO]: $@" >&1
}

run() {
  if [[ $DRYRUN == "true" ]]; then
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')][DRYRUN]: $@" >&1
  else
    $@
    if [[ $? -ne 0 ]]; then
      err "command $@ exited with non-zero status"
    fi
  fi
}

plugin_add() {
  if [ ${PLUGINS:-NIL} == NIL ]; then
    usage
    err "PLUGINS list is empty"
  fi
  for p in $PLUGINS; do
    info "Adding $p Vim package"
    dest_dir="${TARGET_DIR}/$(basename $p | cut -d. -f1)"
    run git submodule add https://github.com/${p} $dest_dir
    run git add .gitmodules $dest_dir
  done
}

plugins_update() {
  info "Updating all Vim packages"
  run git submodule update --remote --merge
}

plugin_remove() {
  if [ ${PLUGINS:-NIL} == NIL ]; then
    usage
    err "PLUGINS list is empty"
  fi
  for p in $PLUGINS; do
    info "Removing $p Vim package"
    dest_dir="${TARGET_DIR}/$(basename $p | cut -d. -f1)"
    run git submodule deinit $dest_dir
    run git rm $dest_dir
    run rm -Rf .git/modules/${dest_dir}
  done
}


#------------------------------------------------------------
# MAIN

CMD=$1; shift
: "${TARGET_DIR:=playbooks/roles/vim/files/dot_vim/pack/local_packages/start}"
: "${PLUGINS:=$@}"

if [ ! -d $TARGET_DIR ]; then
  err "$TARGET_DIR directory does not exist"
fi

case $CMD in
  "add"    ) plugin_add;;
  "remove" ) plugin_remove;;
  "update" ) plugins_update;;
  *        ) usage; err "Unsupported command specified: $CMD";;
esac


