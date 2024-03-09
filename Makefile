# -*- mode: makefile -*-
# vim:ft=make:

OUTPUT_DIR = .
BASH_DEBUG_PREFACE ?= "In vagrant bash completion setup"
BASH_OUTPUT_FILENAME ?= bash-completion-setup.bash
ZSH_DEBUG_PREFACE ?= "In vagrant zsh completion setup"
ZSH_OUTPUT_FILENAME ?= zsh-completion-setup.zsh
VAGRANT_VERSION := $(shell vagrant -v | sed -n -e 's/^[Vv]agrant \([0-9\.]*\)/\1/p')

.PHONY : all
all : bash-completion zsh-completion

.PHONY : bash-completion
bash-completion :
	@echo Generating Vagrant bash completion setup script
	@/bin/echo -e "# -*- mode: sh; sh-shell: bash -*-\\n\
# vim:ft=sh:\\n\
\\n\
# /bin/echo -e '$(BASH_DEBUG_PREFACE)'\\n\
\\n\
# >>>> Vagrant command completion (start)\\n\
. /opt/vagrant/embedded/gems/gems/vagrant-$(VAGRANT_VERSION)/contrib/bash/completion.sh\\n\
# <<<<  Vagrant command completion (end)" > $(OUTPUT_DIR)/$(BASH_OUTPUT_FILENAME)

.PHONY : zsh-completion
zsh-completion :
	@echo Generating Vagrant ZSH completion setup script
	@/bin/echo -e "# -*- mode: sh; sh-shell: zsh -*-\\n\
# vim:ft=sh:\\n\
\\n\
# /bin/echo -e '$(ZSH_DEBUG_PREFACE)'\\n\
\\n\
# >>>> Vagrant command completion (start)\\n\
fpath=(/opt/vagrant/embedded/gems/gems/vagrant-$(VAGRANT_VERSION)/contrib/zsh \$$fpath)\\n\
compinit\\n\
# <<<<  Vagrant command completion (end)" > $(OUTPUT_DIR)/$(ZSH_OUTPUT_FILENAME)

.PHONY : clean
clean :
	rm -f $(OUTPUT_DIR)/$(BASH_OUTPUT_FILENAME)
	rm -f $(OUTPUT_DIR)/$(ZSH_OUTPUT_FILENAME)
