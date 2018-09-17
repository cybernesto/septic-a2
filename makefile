DISK := a2ff18-demo.dsk

C2D := /usr/local/bin/c2d
ACME := /usr/local/bin/acme
JACE := java -jar /Applications/Apple\ II/jace.jar -computer.s6card disk

asm := $(patsubst %.a,%.prg,$(wildcard *.a))

# Default target
all: $(DISK)

# Our phony targets for managing the project
.PHONY: clean
clean:
	$(RM) $(asm) $(DISK)

%.prg: %.a
	$(ACME) -o $@ $<

$(DISK): $(asm)
	c2d $<,a00 $(DISK)

# Start trusty old JACE for debugging	
debug: all
	$(JACE) -s6.d1 $(CURDIR)/$(DISK)
