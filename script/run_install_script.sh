#!/usr/bin/env bash
#
# Run all install script after symlink

run_install_script() {
  echo ''
  info "run install script"

  find . -name install.sh | while read installer;
  do
    sh -c "$installer"
    success "$(dirname $installer)/install.sh"
  done
}
