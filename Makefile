PROGRAM		= hello_asm

ASM		= nasm
ASMFLAGS	= -Ox -f elf64 -w+all -w-reloc-rel-dword
CC		= gcc
CFLAGS		= -O2 -march=native -Wall -Wextra
INCLUDE		= .
LD		= ld
LDFLAGS		=
LDLIBS		= -lm

DEPS		= hello.h
OBJS		= main.o hello.o

.PHONY: all clean debug
all: $(PROGRAM)

debug: CFLAGS	+= -g -Og -DDEBUG
debug: ASMFLAGS	+= -g -Fdwarf -DDEBUG
debug: all

$(PROGRAM): $(DEPS) $(OBJS)
	$(CC) $(LDFLAGS) -o $(PROGRAM) $^ $(LDLIBS)

%.o: %.c $(DEPS)
	$(CC) $(CFLAGS) -o $@ -c $< -I$(INCLUDE)

%.o: %.asm
	$(ASM) $(ASMFLAGS) -o $@ $<

clean:
	rm -f *.o $(PROGRAM)
