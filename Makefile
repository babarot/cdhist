INSTALL_DIR=~/.local/bin
INSTALL_FILE="cdhist.sh"

all:
	@echo "Please run 'make install'"

install:
	@echo ''
	mkdir -p $(INSTALL_DIR)
	cp $(INSTALL_FILE) $(INSTALL_DIR)
	@echo ''
	@echo 'Please restart your shell'
	@echo ''
	@echo 'source $(INSTALL_DIR)/$(INSTALL_FILE)' >>~/.bashrc
