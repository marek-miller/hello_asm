PROGRAM		= hello_asm

SRCS		= main.c hello.s hello.c
OBJS		= $(SRCS:%=%.o)

.PHONY: all build clean
.DEFAULT_GOAL	:= all

all: build

build: $(PROGRAM)

$(PROGRAM): $(OBJS)
	$(CC) -o $@ $(OBJS) $(LDLIBS) $(LDFLAGS)

%.c.o: %.c
	$(CC) -o $@ -c $< -I$(INCLUDE) $(CFLAGS)

%.s.o: %.s
	$(AS) -o $@ $< -I$(INCLUDE) $(ASFLAGS)

clean:
	$(RM) *.o *.d
	$(RM) $(PROGRAM)
