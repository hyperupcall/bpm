#!/usr/bin/env bats

load 'util/init.sh'

@test "list installed packages" {
  mock.command _clone
  create_package username/p1
  create_package username2/p2
  create_package username2/p3
  basher-install username/p1
  basher-install username2/p2

  run basher-list
  assert_success
  assert_line "username/p1"
  assert_line "username2/p2"
  refute_line "username2/p3"
}
