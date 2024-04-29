PROGRAM		= hello_asm
ROOT_DIR	= .

AS		= nasm
ASFLAGS		= -Ox -f elf64 -w+all -w-reloc-rel-dword
CC		= gcc
CFLAGS		= -O2 -march=native -Wall -Wextra
INCLUDE		= $(ROOT_DIR)/include
LD		= ld
LDFLAGS		= -L$(BUILD)
LDLIBS		= -lm

RM		= rm -fv
MKDIR		= mkdir -p
RMDIR		= rm -rfv

SRC		= $(ROOT_DIR)/src
BUILD		= $(ROOT_DIR)/build
OBJ		= $(BUILD)/obj
BIN		= $(BUILD)/bin
LIB		= $(BUILD)/lib

OBJS		= main.o hello_a.o hello_c.o
OBJS		:= $(addprefix $(OBJ)/,$(OBJS))


.PHONY: all clean debug test
all: $(BIN)/$(PROGRAM)

debug: CFLAGS	+= -g -Og -DDEBUG
debug: ASMFLAGS	+= -g -Fdwarf -DDEBUG
debug: all

$(BIN)/$(PROGRAM): $(OBJS) | $(BIN)
	$(CC) -o $@ $^ $(LDLIBS) $(LDFLAGS)

$(OBJ)/%.o: $(SRC)/%.c $(DEPS) | $(OBJ)
	$(CC) -o $@ -c $< -I$(INCLUDE) $(CFLAGS)

$(OBJ)/%.o: $(SRC)/%.s | $(OBJ)
	$(AS) -o $@ $< -I$(INCLUDE) $(ASFLAGS)

$(OBJS): $(OBJ)

$(BIN) $(LIB) $(OBJ):
	$(MKDIR) $@
	
clean:
	$(RM) $(OBJ)/*.o
	$(RMDIR) $(OBJ)

dist-clean: clean
	$(RMDIR) $(BUILD)

