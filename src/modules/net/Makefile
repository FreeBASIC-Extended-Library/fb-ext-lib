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
OBJECTS := $(SOURCES:%.bas=%.o)

LIBRARY_NAME := libext-net.a
LIBRARY_FILE := $(LIBRARY_DIR)/$(LIBRARY_NAME)
LIBRARY_OUT := $(LIBRARY_DIR)/$(LIBRARY_NAME)

.PHONY: net build-net
net build-net: $(LIBRARY_FILE)

$(LIBRARY_FILE): $(OBJECTS)
	$(FBC) $(FBC_LFLAGS) -mt -p $(LIBRARY_DIR) $^ -x $(LIBRARY_OUT)

./%.o: ./%.bas
	$(FBC) $(FBC_CFLAGS) -mt -i $(INCLUDE_DIR) $< -o $@

.PHONY: clean-net
clean-net:
	$(RM) -f $(LIBRARY_FILE)
	$(RM) -f $(OBJECTS)

