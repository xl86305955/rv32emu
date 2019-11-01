BINS = emu-rv32i setup test1

CROSS_COMPILE = riscv-none-embed-
RV32I_CFLAGS = -march=rv32im -mabi=ilp32 -O3 -nostdlib
RV32I_CFLAGS_NO_O = -march=rv32im -mabi=ilp32 -nostdlib
LINK = -T link.ld
DEBUG = -D DEBUG_OUTPUT

CFLAGS = -O3 -Wall
LDFLAGS = -lelf

all: $(BINS)
	
emu-rv32i: emu-rv32i.c
	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)

setup: setup.s
	$(CROSS_COMPILE)gcc $(RV32I_CFLAGS) -c $<

test1: test1.c setup.o
	$(CROSS_COMPILE)gcc $^ $(RV32I_CFLAGS) $(LINK) -o $@ 

frac: frac.c setup.o
	$(CROSS_COMPILE)gcc $^ $(RV32I_CFLAGS_NO_O) $(LINK) -o $@ 

lucas: lucas.c setup.o
	$(CROSS_COMPILE)gcc $^ $(RV32I_CFLAGS_NO_O) $(LINK) -o $@

check: $(BINS)
	./emu-rv32i test1

clean:
	@$(RM) $(BINS)
	@$(RM) *.o
	@$(RM) *.mem
	@$(RM) rom.v
	$(RM) frac
