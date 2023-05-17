GITHUB_PATH = $(HOME)/tmp
BIN_PATH = $(HOME)/.bin
CONFIG_PATH = $(HOME)/.config
DEV_PATH = $(HOME)/.development

.PHONY: config, dependency, install_zlua, install_all, clean, install_vim, install_ranger

config:
	git submodule init
	git submodule update

dependency:
	sh installation_scripts/dependency.sh

install_zlua: config
	sh installation_scripts/z_lua.sh
	cp config/zsh/z_lua.zsh $(HOME)/.config/zsh

install_omz:
	cp config/zsh/* $(HOME)/.config/zsh
	sh installation_scripts/omz.sh
	cp config/zsh/omz.zsh $(HOME)/.config/zsh

install_vim:
	sh installation_scripts/vim.sh

install_ranger:
	sh installation_scripts/ranger.sh

install_development:
	-mkdir -p $(HOME)/code/go $(DEV_PATH)/go
	sh installation_scripts/development.sh

install_all: dependency
	# -mkdir -p $(GITHUB_PATH) $(BIN_PATH) $(CONFIG_PATH) $(DEV_PATH)

clean:
	rm -rf $(GITHUB_PATH)
