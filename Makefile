# Copyright (c) 2007-2024, FreeBASIC Extended Library Development Group
#
# Distributed under the FreeBASIC Extended Library Group license. See
# accompanying file LICENSE.txt or copy at
# https://github.com/FreeBASIC-Extended-Library/fb-ext-lib/blob/master/COPYING

# Makefile - top-level makefile for the FreeBASIC Extended Library

include common.mki

.PHONY: show-help
show-help:
	@echo "Usage: make [options] [goals]"
	@echo
	@echo "build options:"
	@echo "    MT=1              Builds multi-threaded versions of modules, if"
	@echo "                      supported."
	@echo "    NDEBUG=1          Doesn't add debugging info to modules."
	@echo "    EXX=1             Adds error-checking and uses ext/FBMLD."
	@echo "    COPT={xxx}        Adds {xxx} to all fbc compilation command-lines."
	@echo "    LOPT={xxx}        Adds {xxx} to all fbc link command-lines."
	@echo
	@echo "build goals:"
	@echo "    build             Builds static libraries of all FreeBASIC Extended"
	@echo "                      Library modules. This is the default goal."
	@echo "    [build-]{module}  Builds a static library of the module {module}."
	@echo
	@echo "install options:"
	@echo "    INSTALLDIR={path} Installs the FreeBASIC Extended Library into"
	@echo "                      the directory {path}, which is otherwise"
	@echo "                      automatically detected."
	@echo
	@echo "install goals:"
	@echo "    install           Installs all modules of the FreeBASIC Extended"
	@echo "                      Library."
	@echo "    install-{module}  Installs the module {module}."
	@echo "    install-docs      Installs the HTML documentation."
	@echo
	@echo "other goals:"
	@echo "    docs              Builds the HTML documentation using NaturalDocs"
	@echo "    tests             Builds and runs some tests of the FreeBASIC"
	@echo "                      Extended Library."
	@echo "    examples          Builds some example programs."
	@echo "    show-help         Displays options for building and installing."

# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#  Goals
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

.DEFAULT_GOAL := build

# assume any goal not covered here is a module name.
.DEFAULT:
	@cd $(SOURCE_DIR)/modules && $(MAKE) $@

.PHONY: build
build:
	@cd $(SOURCE_DIR)/modules && $(MAKE) build-all

.PHONY: install
install:
	@cd $(SOURCE_DIR)/modules && $(MAKE) install-all
	@echo If you did not recieve any error messages, the
	@echo FreeBASIC Extended Library has been successfully
	@echo installed.
	@echo
	@echo Include files installed in $(INC_INSTALL_DIR)/ext
	@echo Static library files installed in $(LIB_INSTALL_DIR)

.PHONY: uninstall
uninstall:
	@cd $(SOURCE_DIR)/modules && $(MAKE) uninstall-all
	@echo If you did not recieve any error messages, the
	@echo FreeBASIC Extended Library has been successfully
	@echo uninstalled.
	@echo
	@echo Include files uninstalled from $(INC_INSTALL_DIR)/ext
	@echo Static library files uninstalled from $(LIB_INSTALL_DIR)

.PHONY: tests
tests:
	cd $(TESTS_DIR) && $(MAKE)

.PHONY: examples
examples:
	cd $(EXAMPLES_DIR) && $(MAKE)

.PHONY: install-docs
install-docs:
	cd $(DOCS_DIR) && $(MAKE) install


.PHONY: docs
docs:
	cd $(DOCS_DIR) && $(MAKE)


# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#  clean
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

.PHONY: clean-all
clean-all: clean clean-tests clean-examples

.PHONY: clean
clean: clean-modules

.PHONY: clean-tests
clean-tests:
	@echo Removing testing objects..
	cd $(TESTS_DIR) && $(MAKE) clean

.PHONY: clean-examples
clean-examples:
	@echo Removing example executables..
	cd $(EXAMPLES_DIR) && $(MAKE) clean

.PHONY: clean-docs
clean-docs:
	@echo Removing documentation files..
	cd $(DOCS_DIR) && $(MAKE) clean

