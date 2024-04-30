PROGRAM		= hello_asm
ROOT_DIR	= ..

SRCS		= main.c hello.s hello.c
OBJS		= $(SRCS:%=%.o)

.PHONY: all build clean
.DEFAULT_GOAL	:= all

all: build

build: $(PROGRAM)

$(PROGRAM): $(OBJS)
	$(CC) -o $@ $(OBJS) $(LDLIBS) $(LDFLAGS)

%.c.o: %.c
	$(CC) -o $@ -c $< $(CFLAGS)

%.s.o: %.s
	$(AS) -o $@ $< $(ASFLAGS)

clean:
	$(RM) *.o *.d
	$(RM) $(PROGRAM)
