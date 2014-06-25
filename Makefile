INSTALL_DIR =$(HOME)/.local/bin
INSTALL_FILE=cdhist.sh

all:
	mkdir -p $(INSTALL_DIR)
	cp $(INSTALL_FILE) $(INSTALL_DIR)/$(INSTALL_FILE)

install:
	echo "source $(INSTALL_DIR)/cdhist.sh" >>~/.bashrc

.PHONY: all install
