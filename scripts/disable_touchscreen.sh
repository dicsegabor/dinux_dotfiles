#!/bin/bash

ID=$(xinput list | grep -i touchscreen | awk -F'id=' '{print $2}' | awk '{print $1}')

xinput disable "$ID"
