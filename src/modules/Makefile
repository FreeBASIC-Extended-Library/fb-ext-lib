# Copyright (c) 2009, FreeBASIC Extended Library Development Group
#
# Distributed under the FreeBASIC Extended Library Group license. See
# accompanying file LICENSE.txt or copy at
# http://code.google.com/p/fb-extended-lib/wiki/License

# modules.mki - makefile include for module building
#
# TODO: inter-module dependencies

# fix-up path names
export INCLUDE_DIR := ../../$(INCLUDE_DIR)
export SOURCE_DIR  := ../../$(SOURCE_DIR)
export LIBRARY_DIR := ../../$(LIBRARY_DIR)

# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#  MODULE LIST - any new modules go here
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
ALL_MODULES := algorithms containers conversion config
ALL_MODULES += file graphics hash json math memory net
ALL_MODULES += php preprocessor strings logging
ALL_MODULES += debug error fbmld misc templates
ALL_MODULES += xml xstring options database threads
database-properties := hasSources usesCustomMakefile

# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#  MODULE INSTALL DEPENDENCIES - inter-module dependencies go here
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
.PHONY: install-templates
install-templates: install-preprocessor

.PHONY: install-memory
install-memory: install-templates

.PHONY: install-algorithms
install-algorithms: install-memory

.PHONY: install-containers
install-containers: install-algorithms

BUILDABLE_MODULES := $(filter-out Makefile review,$(wildcard *))

CUSTOM_BUILT_MODULES := $(foreach mod,$(BUILDABLE_MODULES),\
                                  $(if $(filter $(mod)/Makefile,$(wildcard $(mod)/*)),$(mod)))

AUTO_BUILT_MODULES := $(filter-out $(CUSTOM_BUILT_MODULES),$(BUILDABLE_MODULES))

# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#  COMPILER FLAGS & LINKER FLAGS
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# paths aren't included here to allow ./*/Makefile to reuse these..
ifeq ($(BITS),64)
	ifeq ($(ARCH),x86)
		export FBC_CFLAGS := -c -w all $(if $(MT),-mt) -asm intel
	else
		export FBC_CFLAGS := -c -w all $(if $(MT),-mt) -asm att
	endif
else
	ifeq ($(ARCH),x86)
		export FBC_CFLAGS := -c -w all $(if $(MT),-mt)
	else
		export FBC_CFLAGS := -c -w all $(if $(MT),-mt) -asm att
	endif
endif
export FBC_LFLAGS := -lib $(if $(MT),-mt)

ifndef NDEBUG
	FBC_CFLAGS += -g
endif

ifdef PROFILE
	FBC_CFLAGS += -profile
endif

ifdef EXX
	FBC_CFLAGS += -exx -d FBEXT_USE_MLD=1
endif

ifdef COPT
	FBC_CFLAGS += $(COPT)
endif
ifdef LOPT
	FBC_LFLAGS += $(LOPT)
endif

# TODO: deprecated
ifdef OPT
	FBC_CFLAGS += $(OPT)
endif

ifeq ($(VERBOSE),2)
	FBC_CFLAGS += -v
endif

# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#  AUTO-BUILD
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# TODO: figure out how to move these into CreateAutoBuildRules:
AutoBuildSources = $(wildcard $(1)/*.bas)
AutoBuildObjects = $(patsubst %.bas,$(if $(MT),%.mt.o,%.o),\
                            $(call AutoBuildSources,$(1)))

AutoBuildLib = libext-$(1)$(if $(MT),.mt).a
AutoBuildLibOut  = $(LIBRARY_DIR)/$(call AutoBuildLib,$(1))
AutoBuildLibFile = $(LIBRARY_DIR)/$(call AutoBuildLib,$(1))

## :::::
## $(1) - module
define CreateAutoBuildRules

.PHONY: $(1) build-$(1)
$(1) build-$(1): $(call AutoBuildLibFile,$(1))

$(call AutoBuildLibFile,$(1)): $(call AutoBuildObjects,$(1))
	$(FBC) $(FBC_LFLAGS) -p $(LIBRARY_DIR) -p $(BINARY_DIR) $$^ -x $(call AutoBuildLibOut,$(1))

$(1)/%.o: $(1)/%.bas
	$(FBC) $(FBC_CFLAGS) -i $(INCLUDE_DIR) $$< -o $$@

$(1)/%.mt.o: $(1)/%.bas
	$(FBC) $(FBC_CFLAGS) -i $(INCLUDE_DIR) $$< -o $$@

.PHONY: clean-$(1)
clean-$(1):
	$(RM) -f $(call AutoBuildObjects,$(1))
	$(RM) -f $(call AutoBuildLibFile,$(1))

endef

# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#  CUSTOM-BUILD
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
## :::::
## $(1) - module
define CreateCustomBuildRules

.PHONY: $(1) build-$(1)
$(1) build-$(1):
	+@$(CD) $(1) && $(MAKE) build-$(1)

.PHONY: clean-$(1)
clean-$(1):
	+@$(CD) $(1) && $(MAKE) clean-$(1)

endef

# generate build targets.
$(foreach mod,$(CUSTOM_BUILT_MODULES),\
          $(eval $(call CreateCustomBuildRules,$(mod))))

$(foreach mod,$(AUTO_BUILT_MODULES),\
          $(eval $(call CreateAutoBuildRules,$(mod))))

.PHONY: build-all
build-all: $(addprefix build-,$(BUILDABLE_MODULES))

.PHONY: clean-modules
clean-modules: $(addprefix clean-,$(BUILDABLE_MODULES))

.PHONY: install-all
install-all: $(addprefix install-,$(ALL_MODULES))

.PHONY: uninstall-all
uninstall-all: $(addprefix uninstall-,$(ALL_MODULES)) uninstall-base

# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
#  AUTO-INSTALL
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# TODO: move this elsewhere..
define CopyFileIfExists
$(if $(wildcard $(1)),$(CP) $(1) $(2))
endef
define RemoveFileIfExists
$(if $(wildcard $(1)),$(RM) $(1))
endef

## :::::
## $(1) - module
define CreateAutoInstallRules

.PHONY: install-$(1)
install-$(1): install-base
	@echo Installing libext-$(1)
	$(call CopyFileIfExists,$(INCLUDE_DIR)/ext/$(1).bi,$(INC_INSTALL_DIR)/ext)
	$(call CopyFileIfExists,$(INCLUDE_DIR)/ext/$(1),$(INC_INSTALL_DIR)/ext)
	$(call CopyFileIfExists,$(LIBRARY_DIR)/libext-$(1).*,$(LIB_INSTALL_DIR)/)

.PHONY: uninstall-$(1)
uninstall-$(1):
	$(call RemoveFileIfExists,$(INC_INSTALL_DIR)/ext/$(1).bi)
	$(call RemoveFileIfExists,$(INC_INSTALL_DIR)/ext/$(1))
	$(call RemoveFileIfExists,$(LIB_INSTALL_DIR)/libext-$(1).*)

endef

.PHONY: install-base
install-base:
	$(MD) $(INC_INSTALL_DIR)/ext
	$(CP) $(wildcard $(INCLUDE_DIR)/ext/detail) $(INC_INSTALL_DIR)/ext/

.PHONY: uninstall-base
uninstall-base:
	$(call RemoveFileIfExists,$(INC_INSTALL_DIR)/ext/detail)
	$(call RemoveFileIfExists,$(INC_INSTALL_DIR)/ext)

# generate build targets.
$(foreach mod,$(ALL_MODULES),$(eval $(call CreateAutoInstallRules,$(mod))))
