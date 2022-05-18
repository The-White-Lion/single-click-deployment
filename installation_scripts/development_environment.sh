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
        ln -s /usr/bin/luajit $bin_dir/lua
        return 0
    elif [[ -n $(lua5.3 -v) ]]
        ln -s /usr/bin/lua5.3 $bin_dir/lua
        return 0
    fi
}

function install_golang() {
    if [[ -n $(go version) ]]; then
        return 0
    fi

    latest="$(curl -s https://golang.org/VERSION?m=text)"
    GOROOT="$development_dir/go"
    GOPATH="$HOME/code/go"
    package_name="$latest.$platform.tar.gz"

    wget --no-check-certificate --continue https://go.dev/dl/$package_name -O "$tmp_dir/go.tar.gz" > /dev/null 2>&1

    if [[ $? -ne 0 ]]; then
        echo "下载失败，检查是否设置代理"
        return 0
    fi

    tar -C "$GOROOT" --strip-components=1 -xzf "$TEMP_DIRECTORY/go.tar.gz"
    blue "配置 go 环境变量"

    {
        export "# Golang config"
        export GOROOT="$GOROOT"
        export PATH="$GOROOT/bin:$PATH"
        export GOPATH="$GOPATH"
        export PATH="$GOPATH/bin:$GOPATH"
    } >> "$zsh_dir/env.zsh"
}

