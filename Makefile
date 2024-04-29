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
 
OBJS		= $(addprefix $(OBJ)/,	\
			 main.o 	)

LIBNAME		= lib$(PROGRAM).so
LIBOBJS		= $(addprefix $(OBJ)/,	\
			 hello_a.o	\
			 hello_c.o	)

.PHONY: all clean debug
all: $(BIN)/$(PROGRAM)

debug: CFLAGS	+= -g -Og -DDEBUG
debug: ASMFLAGS	+= -g -Fdwarf -DDEBUG
debug: all

$(BIN)/$(PROGRAM): $(OBJS) $(LIB)/$(LIBNAME) | $(BIN) 
	$(CC) -o $@ $(OBJS) -l$(PROGRAM) $(LDLIBS) $(LDFLAGS) 

$(LIB)/$(LIBNAME): $(LIBOBJS) | $(LIB)
	$(LD) -shared -o $@ $(LIBOBJS) $(LDLIBS) $(LDFLAGS)

$(OBJ)/%.o: $(SRC)/%.c | $(OBJ)
	$(CC) -o $@ -c $< -I$(INCLUDE) $(CFLAGS)

$(OBJ)/%.o: $(SRC)/%.s | $(OBJ)
	$(AS) -o $@ $< -I$(INCLUDE) $(ASFLAGS)

$(OBJS) $(LIBOBJS): $(OBJ)

$(BIN) $(LIB) $(OBJ):
	$(MKDIR) $@
	
clean:
	$(RM) $(OBJ)/*.o
	$(RMDIR) $(OBJ)

dist-clean: clean
	$(RMDIR) $(BUILD)

