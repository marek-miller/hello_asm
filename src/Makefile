PROGRAM		= hello_asm

SRCS		= main.c hello.s hello.c
OBJS		= $(SRCS:%=%.o)
DEPS		= $(SRCS:%=%.d)


.PHONY: all build clean
.DEFAULT_GOAL	:= all

-include $(DEPS)

all: build

build: $(PROGRAM)

$(PROGRAM): $(OBJS)
	$(CC) -o $@ $(OBJS) $(LDLIBS) $(LDFLAGS)

%.c.o: %.c
	$(CC) -MMD -MP $(CFLAGS) -o $@ -c $< 

%.s.o: %.s
	$(AS) -o $@ $< $(ASFLAGS)

clean:
	$(RM) *.o *.d
	$(RM) $(PROGRAM)
