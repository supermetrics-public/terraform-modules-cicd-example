#!/bin/bash

set -e

# Set the yamllint bin path
YAMLLINT_BIN="$( which yamllint )"

# Set the yamllint config path
YAMLLINT_CONFIG="$PWD/.github/configs/.yamllint.yml"

#
# Process each file.
#
run_yaml_linter()
{
   for i in $( find . -type d \( -path ./.git -o -path ./vendor -o -path ./logs \) -prune -false -o \( -iname '*.yml' -o -iname '*.yaml' \) ); do

      #
      # If the result of the formatted file throws a parse error then we've got a failure.
      #
      if ! ( $YAMLLINT_BIN -f parsable -c "$YAMLLINT_CONFIG" "$i" >/dev/null 2>&1 ); then
          echo "File $i is not valid YAML"
          echo "Please run '$YAMLLINT_BIN -f parsable -c $YAMLLINT_CONFIG $i'"
          exit 1
      else
          echo "OK: $i"
      fi

   done
}

run_yaml_linter

#
# All done.
#
exit 0
