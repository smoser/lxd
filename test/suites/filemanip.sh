test_filemanip() {
  if [ -n "${TRAVIS_PULL_REQUEST:-}" ]; then
    return
  fi

  ensure_import_testimage

  lxc launch testimage filemanip
  lxc exec filemanip -- ln -s /tmp/ /tmp/outside
  lxc file push main.sh filemanip/tmp/outside/

  [ ! -f /tmp/main.sh ]
  [ -f ${LXD_DIR}/containers/filemanip/rootfs/tmp/main.sh ]

  lxc delete filemanip
}
