#!/bin/bash

set -u
source "utils/tools.sh"

pip3 install ranger-fm --user

conf_dir="${HOME}/.config/ranger"
backup "${conf_dir}"
cp -r "config/ranger" "${conf_dir}"

# plugin
git_clone "cdump/ranger-devicons2" "${HOME}/.config/ranger/plugins/devicons2" "ranger"
