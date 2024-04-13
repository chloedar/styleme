#!/bin/bash
# database

# Stop on errors
# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
set -Eeuo pipefail

# Sanity check command line options
usage() {
  echo "Usage: $0 (create|destroy|reset|dump)"
}

if [ $# -ne 1 ]; then
  usage
  exit 1
fi

# Parse argument.  $1 is the first argument
case $1 in
  "create")
    mkdir -p var/uploads
    sqlite3 var/styleme.sqlite3 < sql/schema.sql
    sqlite3 var/styleme.sqlite3 < sql/data.sql
    cp sql/uploads/* var/uploads/
    ;;

  "destroy")
    rm -rf var/styleme.sqlite3 var/uploads
    ;;

  "reset")
    rm -rf var/styleme.sqlite3 var/uploads
    mkdir -p var/uploads
    sqlite3 var/styleme.sqlite3 < sql/schema.sql
    sqlite3 var/styleme.sqlite3 < sql/data.sql
    cp sql/uploads/* var/uploads/
    ;;


  *)
    usage
    exit 1
    
esac