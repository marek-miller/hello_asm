AS		= nasm
ASFLAGS		= -Ox -felf64 -w+all -w-reloc-rel-dword
CC		= gcc
CFLAGS		= -O2 -march=native -Wall -Wextra
LD		= ld
LDFLAGS		=
LDLIBS		= -lm
MAKEFLAGS	=
RM		= rm -fv
MKDIR		= mkdir -p
RMDIR		= rm -rfv

ROOT_DIR	= .
SRC		= $(ROOT_DIR)/src
TEST		= $(ROOT_DIR)/test

export

.PHONY: all build build-debug clean test
.DEFAULT_GOAL	:= all

build-debug: CFLAGS	+= -DDEBUG -g -Og
build-debug: ASFLAGS	+= -DDEBUG -g -Fdwarf
build-debug: build

all: build

build:
	$(MAKE) $(MAKEFLAGS) -C $(SRC)  build
	$(MAKE) $(MAKEFLAGS) -C $(TEST) build

test: build
	$(MAKE) $(MAKEFLAGS) -C $(TEST) test

clean:
	$(MAKE) $(MAKEFLAGS) -C $(SRC)  clean
	$(MAKE) $(MAKEFLAGS) -C $(TEST) clean
