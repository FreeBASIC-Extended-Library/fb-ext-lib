FBC_CFLAGS := -g -i ../include/freebasic
FBC_LFLAGS := -p ../lib/$(TARGET)

TESTS_MAIN := main$(EXE_EXT)


TESTS_DIRS := preprocessor algorithms strings containers math sort php hash memory xml conversion misc file


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
	$(RM) -f $(TESTS_MAIN) main.o
	$(RM) -f $(TESTS_OBJS)
