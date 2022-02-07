# fbext examples Makefile

EX_DIRS := containers database graphics hash math memory misc net preprocessor sort strings xml options logging threads
EX_SRCS := $(foreach dir,$(EX_DIRS),$(wildcard $(dir)/*.bas))
EX_EXES := $(EX_SRCS:%.bas=%$(EXE_EXT))

FBC_CFLAGS := -g -i ../$(INCLUDE_DIR) 
FBC_LFLAGS := -p ../$(LIBRARY_DIR)

ifeq ($(ARCH), x86)
	ifeq ($(BITS),64)
		FBC_CFLAGS += -arch x86-64
	else
		FBC_CFLAGS += -arch 586
	endif
endif

all : $(EX_EXES)

%$(EXE_EXT) : %.bas
	$(FBC) $(FBC_CFLAGS) $(FBC_LFLAGS) $^ -x $@

.PHONY : clean
clean :
	$(RM) -f $(EX_EXES)
