PROGRAM		= hello_asm

ASM		= nasm
ASMFLAGS	= -Ox -f elf64 -w+all -w-reloc-rel-dword
CC		= gcc
CFLAGS		= -O2 -march=native -Wall -Wextra
INCLUDE		= include
LD		= ld
LDFLAGS		=
LDLIBS		= -lm

RM		= rm -f
MKDIR		= mkdir -p
RMDIR		= rm -rf

SRC		= src
BUILD		= build
OBJ		= $(BUILD)/obj


OBJS		= main.o hello.o

.PHONY: all clean debug
all: $(BUILD)/$(PROGRAM)

debug: CFLAGS	+= -g -Og -DDEBUG
debug: ASMFLAGS	+= -g -Fdwarf -DDEBUG
debug: all

$(BUILD)/$(PROGRAM): $(addprefix $(OBJ)/,$(OBJS))
	$(CC) $(LDFLAGS) -o $@ $^ $(LDLIBS)

$(OBJ)/%.o: $(SRC)/%.c $(DEPS) | $(OBJ)
	$(CC) $(CFLAGS) -o $@ -c $< -I$(INCLUDE)

$(OBJ)/%.o: $(SRC)/%.asm | $(OBJ)
	$(ASM) $(ASMFLAGS) -o $@ $< -I$(INCLUDE)

$(OBJ):
	$(MKDIR) $@
	
clean:
	$(RM) $(OBJ)/*.o
	$(RMDIR) $(OBJ)

