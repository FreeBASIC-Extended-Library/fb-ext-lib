FBC_CFLAGS := -g -i ../include/freebasic -enullptr -w all
FBC_LFLAGS := -p ../$(LIBRARY_DIR) -p ../$(BINARY_DIR)

ifeq ($(ARCH), x86)
	ifeq ($(BITS),64)
		FBC_CFLAGS += -arch x86-64
	else
		FBC_CFLAGS += -arch 686
	endif
endif

TESTS_MAIN := main$(EXE_EXT)


TESTS_DIRS := algorithms containers conversion database file hash json math memory misc php preprocessor sort strings xml


TESTS_SRCS := $(foreach dir,$(TESTS_DIRS),$(wildcard $(dir)/*.bas))
TESTS_OBJS := $(TESTS_SRCS:%.bas=%.o)

all : run-tests

run-tests: $(TESTS_MAIN)
	@$(EXE_PFX)$(TESTS_MAIN)

%.o : %.bas
	$(FBC) $(OPT) -c $(FBC_CFLAGS) $< -o $@

main.o : main.bas
	$(FBC) $(OPT) -c $(FBC_CFLAGS) -m main $< -o $@

$(TESTS_MAIN) : $(TESTS_OBJS) main.o
	$(FBC) $(OPT) $(FBC_LFLAGS) $(FBC_CFLAGS) $(TESTS_OBJS) main.o -x $(TESTS_MAIN)

.PHONY : clean
clean :
	-$(RM) -f $(TESTS_MAIN) main.o
	-$(RM) -f $(TESTS_OBJS)
