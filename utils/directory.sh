#!/bin/bash

[[ ! -d "${CONFIG_DIR}" ]] && mkdir -p "${CONFIG_DIR}"

[[ ! -d "${GITHUB_DIR}" ]] && mkdir -p "${GITHUB_DIR}"

[[ ! -d "${BIN_DIR}" ]] && mkdir -p "${BIN_DIR}"

[[ ! -d "${DEV_ENV_DIR}" ]] && mkdir -p "${DEV_ENV_DIR}"

[[ ! -d "${CODE_DIR}" ]] && mkdir -p "${CODE_DIR}"

[[ ! -d "${TMP_DIR}" ]] && mkdir -p "${TMP_DIR}"

[[ ! -d "${ZSH_DIR}" ]] && mkdir -p "${ZSH_DIR}"

[[ ! -d "${FONT_DIR}" ]] && mkdir -p "${FONT_DIR}"
