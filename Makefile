PROGRAM		= hello_asm

INC		=
SRC		= src
OBJ		= $(SRC)

HEADERS		= hello.h
SRCS		= main.c hello.s hello.c
OBJS		= $(SRCS:%=$(OBJ)/%.o)

AS		= nasm
ASFLAGS		= -Ox -felf64 -w+all -w-reloc-rel-dword
CC		= gcc
CFLAGS		= -O2 -march=native -Wall -Wextra
INCLUDE		=
LD		= ld
LDFLAGS		=
LDLIBS		= -lm

RM		= rm -fv
MKDIR		= mkdir -p
RMDIR		= rm -rfv


.PHONY: all clean debug
.DEFAULT_GOAL	:= all

debug: CFLAGS	+= -DDEBUG -g -Og
debug: ASFLAGS	+= -DDEBUG -g -Fdwarf
debug: all

all: $(PROGRAM)

$(PROGRAM): $(OBJS)
	$(CC) -o $@ $(OBJS) $(LDLIBS) $(LDFLAGS)

$(OBJ)/%.c.o: $(SRC)/%.c
	$(CC) -o $@ -c $< -I$(INC) $(CFLAGS)

$(OBJ)/%.s.o: $(SRC)/%.s
	$(AS) -o $@ $< -I$(INC) $(ASFLAGS)

clean:
	$(RM) $(OBJ)/*.o

dist-clean: clean
	$(RM) $(PROGRAM)
