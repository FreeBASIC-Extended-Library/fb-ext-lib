# Copyright (c) 2009, FreeBASIC Extended Library Development Group
#
# Distributed under the FreeBASIC Extended Library Group license. See
# accompanying file LICENSE.txt or copy at
# http://code.google.com/p/fb-extended-lib/wiki/License

# Custom Makefile demonstration
#

# fix-up path names
INCLUDE_DIR := ../$(INCLUDE_DIR)
SOURCE_DIR  := ../$(SOURCE_DIR)
LIBRARY_DIR := ../$(LIBRARY_DIR)

SOURCES := $(wildcard *.bas)
OBJECTS := $(SOURCES:%.bas=%$(if $(MT),.mt).o)

LIBRARY_NAME := libext-math$(if $(MT),.mt).a
LIBRARY_FILE := $(LIBRARY_DIR)/$(LIBRARY_NAME)
LIBRARY_OUT := $(LIBRARY_DIR)/$(LIBRARY_NAME)

.PHONY: math build-math
math build-math: $(LIBRARY_FILE)

$(LIBRARY_FILE): $(OBJECTS)
	$(FBC) $(FBC_LFLAGS) -p $(LIBRARY_DIR) $^ -x $(LIBRARY_OUT)

./%.o: ./%.bas
	$(FBC) $(FBC_CFLAGS) -i $(INCLUDE_DIR) $< -o $@

./%.mt.o: ./%.bas
	$(FBC) $(FBC_CFLAGS) -i $(INCLUDE_DIR) $< -o $@

.PHONY: clean-math
clean-math:
	$(RM) -f $(LIBRARY_FILE)
	$(RM) -f $(OBJECTS)

