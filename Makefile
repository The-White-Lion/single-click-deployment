GITHUB_PATH = $(HOME)/tmp
BIN_PATH = $(HOME)/.bin
CONFIG_PATH = $(HOME)/.config
DEV_PATH = $(HOME)/.development

INSTALL := install_zlua, install_all, install_vim, install_docker, \
					 install_ranger, install_nodejs, install_python, install_neovim
deps := config, dependency
.PHONY: $(deps), $(INSTALL), clean

config:
	git submodule init
	git submodule update

dependency:
	bash installation/dependency.sh

install_go:
	bash installation/go.sh

install_nodejs:
	bash installation/nodejs.sh

install_python:
	bash installation/python.sh

install_docker:
	bash installation/docker.sh

install_neovim:
	bash installation/neovim.sh

install_omz:
	cp config/zsh/* $(HOME)/.config/zsh
	bash installation/omz.sh
	cp config/zsh/omz.zsh $(HOME)/.config/zsh

install_ranger:
	bash installation/ranger.sh

install_vim:
	bash installation/vim.sh

install_zlua:
	bash installation/z_lua.sh
	cp config/zsh/z_lua.zsh $(HOME)/.config/zsh

install_all: $(install)
	# -mkdir -p $(GITHUB_PATH) $(BIN_PATH) $(CONFIG_PATH) $(DEV_PATH)
	echo all

clean:
	echo clean
	rm -rf $(GITHUB_PATH)
