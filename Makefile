PROGRAM		= hello_asm

ASM			= nasm
ASMFLAGS	= -f elf64 -w+all -g -Fdwarf
CC			= gcc
CFLAGS		= -Wall -Wextra -g
DEPS		= hello.h
INCLUDE		= .
LD			= ld
LDFLAGS		=

.PHONY: all clean
all: $(PROGRAM)

$(PROGRAM): $(DEPS) main.o hello.o
	$(CC) $(LDFLAGS) -o $(PROGRAM) $^

%.o: %.c $(DEPS)
	$(CC) $(CFLAGS) -o $@ -c $< -I$(INCLUDE)

%.o: %.asm
	$(ASM) $(ASMFLAGS) -o $@ $<

clean:
	rm -f *.o $(PROGRAM)
