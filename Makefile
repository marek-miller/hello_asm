ROOT_DIR	= .
INC		= $(ROOT_DIR)/include

AS		= nasm
ASFLAGS		= -Ox -felf64 -w+all -w-reloc-rel-dword
CC		= gcc
CFLAGS		= -O2 -march=native -Wall -Wextra -I$(INC)
LD		= ld
LDFLAGS		=
LDLIBS		= -lm
RM		= rm -fv
MKDIR		= mkdir -p
RMDIR		= rm -rfv

SRC		= hello

export

.PHONY: all build build-debug build-test clean test
.DEFAULT_GOAL	:= all

build-debug: CFLAGS	+= -DDEBUG -g -Og
build-debug: ASFLAGS	+= -DDEBUG -g -Fdwarf
build-debug: build build-test

all: build build-test

build:
	$(MAKE) -C $(SRC) build

build-test:
	$(MAKE) -C $(SRC) build-test

test:
	$(MAKE) -C $(SRC) test

clean:
	$(MAKE) -C $(SRC) clean

