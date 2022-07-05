TARGETS_PLATE_L=stl/plateL/1_bot.stl stl/plateL/2_col.stl stl/plateL/3_mid.stl stl/plateL/4_row.stl stl/plateL/5_top1.stl stl/plateL/6_top2.stl
TARGETS_PLATE_R=stl/plateR/1_bot.stl stl/plateR/2_col.stl stl/plateR/3_mid.stl stl/plateR/4_row.stl stl/plateR/5_top1.stl stl/plateR/6_top2.stl
TARGETS_KEYCAPS_L=stl/keycapsL/1_text.stl stl/keycapsL/2_top.stl stl/keycapsL/3_body.stl
TARGETS_KEYCAPS_R=stl/keycapsR/1_text.stl stl/keycapsR/2_top.stl stl/keycapsR/3_body.stl

TARGETS=$(TARGETS_PLATE_L) $(TARGETS_PLATE_R) $(TARGETS_KEYCAPS_L) $(TARGETS_KEYCAPS_R)

all: $(TARGETS)

stl:
	mkdir -p stl/plateL
	mkdir -p stl/plateR
	mkdir -p stl/keycapsL
	mkdir -p stl/keycapsR

stl/plateL/%.stl: src/plate/%.scad stl
	openscad --hardwarnings -o $@ $< -D's=1' 2>&1 | grep -v 'CGAL'

stl/plateR/%.stl: src/plate/%.scad stl
	openscad --hardwarnings -o $@ $< -D's=-1' 2>&1 | grep -v 'CGAL'

stl/keycapsL/%.stl: src/keycaps/%.scad stl
	openscad --hardwarnings -o $@ $< -D's=1' 2>&1 | grep -v 'CGAL'

stl/keycapsR/%.stl: src/keycaps/%.scad stl
	openscad --hardwarnings -o $@ $< -D's=-1' 2>&1 | grep -v 'CGAL'

clean:
	rm $(TARGETS)

