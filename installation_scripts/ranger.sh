#!/bin/bash

pip3 install ranger-fm --user
cp -r "$TMP_DIR"/config/ranger "$CONFIG_DIR"

# Plugin
git clone https://github.com/cdump/ranger-devicons2 "$CONFIG_DIR"/ranger/plugins/devicons2
