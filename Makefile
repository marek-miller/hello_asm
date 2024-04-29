PROGRAM		= helloasm
ROOT_DIR	= .

AS		= nasm
ASFLAGS		= -Ox -f elf64 -w+all -w-reloc-rel-dword
CC		= gcc
CFLAGS		= -O2 -march=native -Wall -Wextra
INCLUDE		= $(ROOT_DIR)/include
LD		= ld
LDFLAGS		= -L$(LIB)
LDLIBS		= -lm

RM		= rm -fv
MKDIR		= mkdir -p
RMDIR		= rm -rfv

SRC		= $(ROOT_DIR)/src
BUILD		= $(ROOT_DIR)/build
BIN		= $(BUILD)/bin
LIB		= $(BUILD)/lib
OBJ		= $(BUILD)/obj

HEADERS		= hello.h

SRCS		= main.c
OBJS		= $(SRCS:%=$(OBJ)/%.o)

LIBNAME		= lib$(PROGRAM).so
LIBSRCS		= hello.s hello.c
LIBOBJS		= $(LIBSRCS:%=$(OBJ)/%.o)


.PHONY: all clean debug
.DEFAULT: all

all: $(BIN)/$(PROGRAM) $(LIB)/$(LIBNAME)

debug: CFLAGS	+= -g -Og -DDEBUG
debug: ASMFLAGS	+= -g -Fdwarf -DDEBUG
debug: all

$(BIN)/$(PROGRAM): $(OBJS) $(LIB)/$(LIBNAME) | $(BIN) 
	$(CC) -o $@ $(OBJS) -l$(PROGRAM) $(LDLIBS) $(LDFLAGS)

$(LIB)/$(LIBNAME): $(LIBOBJS) | $(LIB)
	$(LD) -shared -o $@ $(LIBOBJS) $(LDLIBS) $(LDFLAGS)

$(OBJ)/%.c.o: $(SRC)/%.c | $(INCLUDE)/$(HEADERS) $(OBJ)
	$(CC) -o $@ -c $< -I$(INCLUDE) -I$(SRC) $(CFLAGS)

$(OBJ)/%.s.o: $(SRC)/%.s | $(OBJ)
	$(AS) -o $@ $< -I$(INCLUDE) -I$(SRC) $(ASFLAGS)

$(OBJS) $(LIBOBJS): $(OBJ)

$(BIN) $(LIB) $(OBJ):
	$(MKDIR) $@
	
clean:
	$(RM) $(OBJ)/*.o
	$(RMDIR) $(OBJ)

dist-clean: clean
	$(RMDIR) $(BUILD)

