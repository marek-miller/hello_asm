AS		= nasm
ASFLAGS		= -Ox -felf64 -w+all -w-reloc-rel-dword
CC		= gcc
CFLAGS		= -O2 -march=native -Wall -Wextra
INCLUDE		= include
LD		= ld
LDFLAGS		=
LDLIBS		= -lm
MAKEFLAGS	= #-j6
RM		= rm -fv
MKDIR		= mkdir -p
RMDIR		= rm -rfv

export

.PHONY: all clean debug test
.DEFAULT_GOAL	:= all

debug: CFLAGS	+= -DDEBUG -g -Og
debug: ASFLAGS	+= -DDEBUG -g -Fdwarf
debug: all

all:
	cd src && $(MAKE) $(MAKEFLAGS)

test:	all
	cd test && $(MAKE) $(MAKEFLAGS)

clean:
	cd src && $(MAKE) clean
	cd test && $(MAKE) clean
