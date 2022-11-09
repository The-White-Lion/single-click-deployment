function install_rust() {
    echo rust
}

function install_node() {
    echo node
}

function install_lua() {
    if [[ -n $(lua -v) ]]; then
        return 0
    elif [[ -n $(luajit -v) ]]; then
        ln -s /usr/bin/luajit $BIN_DIR/lua
        return 0
    elif [[ -n $(lua5.3 -v) ]]; then
        ln -s /usr/bin/lua5.3 $BIN_DIR/lua
        return 0
    fi
}

function install_golang() {
    if [[ -n $(go version) ]]; then
        return 0
    fi

    if [[ $os_architecture = "armv7l" ]]; then
        platform="linux-armv6l"
    fi

    version="$(curl -s https://go.dev/VERSION?m=text)"
    GOROOT="$DEV_ENV_DIR/go"
    GOPATH="$CODE_DIR/go"
    package_name="$version.$platform.tar.gz"
    # https://go.dev/dl/go1.19.1.linux-armv6l.tar.gz
    package_url="https://go.dev/dl/$package_name"

    [[ ! -d "$GOROOT" ]] && mkdir "$GOROOT"
    [[ ! -d "$GOPATH" ]] && mkdir "$GOPATH"
    wget --no-check-certificate --continue $package_url -O "$TMP_DIR/go.tar.gz" > /dev/null 2>&1

    if [[ $? -ne 0 ]]; then
        echo "下载失败，检查是否设置代理"
        echo "下载链接：$package_url"
        return 0
    fi

    tar -C "$GOROOT" --strip-components=1 -xzf "$TMP_DIR/go.tar.gz"
    blue "配置 go 环境变量"

    {
        echo "# Golang config"
        echo "export GOROOT=${GOROOT}"
        echo 'export PATH="$GOROOT/bin:$PATH"'
        echo "export GOPATH=${GOPATH}"
        echo 'export PATH="$GOPATH/bin:$PATH"'
    } >> "$ZSH_DIR/env.zsh"
}
