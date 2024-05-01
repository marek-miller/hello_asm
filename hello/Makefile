PROGRAM		= hello

SRCS		= hello.c hello.s
OBJS		= $(SRCS:%=%.o)
DEPS		= $(SRCS:%=%.d)


.PHONY: all
.DEFAULT_GOAL	:= all

all: build build-test


###########
# PROGRAM #
###########

PROG_SRCS	= main.c
PROG_OBJS	= $(PROG_SRCS:%=%.o)
PROG_DEPS	= $(PROG_SRCS:%=%.d)


.PHONY: build clean

-include $(DEPS)
-include $(PROG_DEPS)

build: $(PROGRAM)

$(PROGRAM): $(PROG_OBJS) $(OBJS)
	$(CC) -o $@ $^ $(LDLIBS) $(LDFLAGS)

%.c.o: %.c
	$(CC) -MMD -MP $(CFLAGS) -o $@ -c $<

%.s.o: %.s
	$(AS) $(ASFLAGS) -o $@ $<


########
# TEST #
########

TEST		= tst-hello
TEST_SRCS	= $(TEST).c
TEST_OBJS	= $(TEST_SRCS:%=%.o)
TEST_DEPS	= $(TEST_SRCS:%=%.d)


.PHONY: build-test test

-include $(DEPS)
-include $(TEST_DEPS)

build-test: $(TEST)

$(TEST): $(TEST_OBJS) $(OBJS)
	$(CC) -o $@ $^ $(LDLIBS) $(LDFLAGS)

test:
	@ ./$(TEST)

clean:
	$(RM) $(OBJS) $(DEPS)
	$(RM) $(PROG_OBJS) $(PROG_DEPS) $(PROGRAM)
	$(RM) $(TEST_OBJS) $(TEST_DEPS) $(TEST)

