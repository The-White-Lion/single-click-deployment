GITHUB_PATH = $(HOME)/.github
CONFIG_PATH = $(HOME)/.config
DEV_PATH = $(HOME)/.development

INSTALL := install_omz install_development install_zlua install_vim \
					 install_docker install_ranger install_neovim
.PHONY: download_config dependency clean post install_all $(INSTALL)

download_config:
	git submodule init
	git submodule update

dependency:
	bash installation/dependency.sh

post:
	bash utils/post.sh

install_development:
	bash installation/go.sh
	bash installation/nodejs.sh
	bash installation/python.sh

install_docker:
	#bash installation/docker.sh
	echo docker

install_neovim:
	#bash installation/neovim.sh
	echo neovim

install_omz:
	bash installation/omz.sh

install_ranger:
	bash installation/ranger.sh

install_vim:
	bash installation/vim.sh

install_zlua:
	bash installation/z_lua.sh
	cp config/zsh/z_lua.zsh $(HOME)/.config/zsh

install_all: dependency
	@-mkdir -p $(GITHUB_PATH) $(CONFIG_PATH) $(DEV_PATH)
	@make download_config
	@make $(INSTALL)
	@make post

clean:
	@echo clean...
	rm -rf $(GITHUB_PATH) $(CONFIG_PATH) $(DEV_PATH)
