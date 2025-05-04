#!/bin/bash

ENV_FILE="$XDG_RUNTIME_DIR/dunst_ids.env"
START_ID=1000

declare -A keys=(
  [brightness]=0
  [volume]=1
  [battery]=2
  [bluetooth]=3
  [datetime]=4
  [network]=5
  [resources]=6
  [weather]=7
)

{
  for key in "${!keys[@]}"; do
    id=$((START_ID + keys[$key]))
    echo "DUNST_ID_${key^^}=$id"
  done
} >"$ENV_FILE"
