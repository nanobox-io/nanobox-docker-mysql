# source docker helpers
. util/docker.sh

@test "Start Container" {
  start_container "mysql-test"
}

@test "Verify mysql installed" {
  # ensure mysql executable exists
  run docker exec "mysql-test" bash -c "[ -f /data/sbin/mysqld ]"

  [ "$status" -eq 0 ]
}

@test "Stop Container" {
  stop_container "mysql-test"
}
