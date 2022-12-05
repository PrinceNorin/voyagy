#!/bin/bash

set -e

pid=tmp/pids/server.pid
if [ -f "$pid" ]; then
  rm $pid
fi

bundle exec rails s -b 0.0.0.0
