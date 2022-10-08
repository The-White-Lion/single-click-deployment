#!/bin/bash

GITHUB_DIR="$HOME/.github"
BIN_DIR="$HOME/.bin"
CONFIG_DIR="$HOME/.config"
DEV_ENV_DIR="$HOME/.development"
CODE_DIR="$HOME/code"
TMP_DIR="$HOME/.tmp"
ZSH_DIR="$CONFIG_DIR/zsh"

[[ ! -d "$ZSH_DIR" ]] && mkdir "$ZSH_DIR"

[[ ! -d "$GITHUB_DIR" ]] && mkdir "$GITHUB_DIR"

[[ ! -d "$BIN_DIR" ]] && mkdir "$BIN_DIR"

[[ ! -d "$CONFIG_DIR" ]] && mkdir "$CONFIG_DIR"

[[ ! -d "$DEV_ENV_DIR" ]] && mkdir "$DEV_ENV_DIR"

[[ ! -d $CODE_DIR ]] && mkdir "$CODE_DIR"

[[ ! -d $TMP_DIR ]] && mkdir "$TMP_DIR"
