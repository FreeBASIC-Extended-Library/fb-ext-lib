# fbext examples Makefile
#
EX_DIRS := containers hash memory preprocessor sort strings xml options logging threads database graphics math misc net
EX_SRCS := $(foreach dir,$(EX_DIRS),$(wildcard $(dir)/*.bas))
EX_EXES := $(EX_SRCS:%.bas=%$(EXE_EXT))

FBC_CFLAGS := -g -i ../$(INCLUDE_DIR) -w all -enullptr 
FBC_LFLAGS := -p ../$(LIBRARY_DIR) -p ../$(BINARY_DIR)

ifeq ($(ARCH), x86)
	ifeq ($(BITS),64)
		FBC_CFLAGS += -arch x86-64
	else
		FBC_CFLAGS += -arch 686
	endif
endif

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

all : $(EX_EXES)

%$(EXE_EXT) : %.bas
	-$(FBC) $(FBC_CFLAGS) $(FBC_LFLAGS) $^ -x $@

.PHONY : clean
clean :
	-$(RM) -f $(EX_EXES)
