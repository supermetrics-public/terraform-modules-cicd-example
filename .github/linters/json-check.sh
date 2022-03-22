#!/bin/bash
#
# Validate any and all JSON files within this repository.
#
# Do this using the `json.tool`  python-module.
#

set -e

#
# Process each file.
#
run_json_linter()
{
  # @TODO add .json.tpl (terraform template) to be checked once all the templates are ok
   for i in $( find . -type d \( -path ./.git -o -path ./vendor -o -path ./logs \) -prune -false -o \( -iname '*.json' \) ); do
     #
     # Test it.
     #
     if ! ( python -mjson.tool < "$i" >/dev/null 2>&1 ); then
          echo "File $i is not valid JSON"
          echo "Please run 'python -mjson.tool < $i'"
          exit 1
     else
          echo "OK: $i"
     fi

   done
}

run_json_linter

#
# All done.
#
exit 0
