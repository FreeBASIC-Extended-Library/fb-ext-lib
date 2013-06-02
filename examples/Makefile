# fbext examples Makefile

EX_DIRS := containers database file graphics hash math memory net preprocessor sort strings xml options
EX_SRCS := $(foreach dir,$(EX_DIRS),$(wildcard $(dir)/*.bas))
EX_EXES := $(EX_SRCS:%.bas=%$(EXE_EXT))

FBC_CFLAGS := -g -i ../$(INCLUDE_DIR)
FBC_LFLAGS := -p ../$(LIBRARY_DIR) -p ../bin

all : $(EX_EXES)

%$(EXE_EXT) : %.bas
	$(FBC) $(FBC_CFLAGS) $(FBC_LFLAGS) $^ -x $@

.PHONY : clean
clean :
	$(RM) -f $(EX_EXES)
