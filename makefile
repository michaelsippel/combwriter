TARGETS_PLATE_L=$(shell find -name 'plateL*.scad' | sed 's~\.scad~\.stl~g')
TARGETS_PLATE_R=$(shell find -name 'plateR*.scad' | sed 's~\.scad~\.stl~g')

TARGETS=$(TARGETS_PLATe_L) $(TARGETS_PLATE_R)

all: $(TARGETS)

%.stl: %.scad
	openscad -o $@ $<

clean:
	rm $(TARGETS)

