PROGRAM		= hello_test
ROOT_DIR	= ..

CFLAGS		+= -I$(ROOT_DIR)/$(SRC)

SRCS		= hello_test.c
OBJS		= $(SRCS:%=%.o)

TEST_OBJS	= $(addprefix $(ROOT_DIR)/$(SRC)/, hello.c.o hello.s.o)

.PHONY: all build clean test
.DEFAULT_GOAL	:= all

all: build

build: $(PROGRAM)

$(PROGRAM): $(OBJS) $(TEST_OBJS)
	$(CC) -o $@ $^ $(LDLIBS) $(LDFLAGS)

%.c.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

%.s.o: %.s
	$(AS) -o $@ $< $(ASFLAGS)

clean:
	$(RM) *.o *.d
	$(RM) $(PROGRAM)

test: build
	@ ./$(PROGRAM)
