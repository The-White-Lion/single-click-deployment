#!/bin/bash

set -u

pip3 install ranger-fm --user
cp -r "config/ranger" "${HOME}/.config/ranger"

# plugin
git clone https://github.com/cdump/ranger-devicons2 "${HOME}/.config/ranger/plugins/devicons2"
