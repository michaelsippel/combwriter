include <layout.scad>

module row_connections(w=3.5, h=0.4) {
  for(y = [0:2]) {
    translate([0, y*yoff+8, 0])
      union() {
        translate([-38,-4,0])
	  rotate([0,0,-60])
	  cube([w, 90, h], center=true);

	for(x = [-3:0]) {
	  translate([x*xoff - 3.2 - sign(xoff)*scale_map_x[x+3], x*0.5*yoff + 10, 0])
	    cube([w, 12, h], center=true);
	}

	translate([26,3,0])
	  rotate([0,0,60])
	  cube([w, 61, h], center=true);

	for(x = [1:3]) {
	  translate([x*xoff - 3.2 - sign(xoff)*scale_map_x[x+3], -x*0.5*yoff+12, 0])
	    cube([w, 13, h], center=true);
	}
    }
  }

  translate([0, -10, 0])
    union() {
      translate([36,-4,0])
	rotate([0,0,60])
	cube([w, 93, h], center=true);

      for(x = [0:2]) {
	translate([x*xoff - 3 - sign(xoff)*scale_map_x[x+3], -x*0.5*yoff+11, 0])
	  cube([w, 15, h], center=true);
      }

      translate([4*xoff+4, 36 - 3*yoff, 0])
	cube([w, 25, h], center=true);
  }
}

module col_connections(w=3.5, h=0.4) {
  for(x = [-3:-1]) {
      translate([x*xoff + 3.5 - sign(xoff)*scale_map_x[x+3], 48 + x*0.555*yoff, 0])  
	cube([w, 65, h], center=true);
  }

  for(x = [0:2]) {
    translate([x*xoff + 3.5 - sign(xoff)*scale_map_x[x+3], 38 - x*0.555*yoff, 0])  
    cube([w, 85, h], center=true);
  }

  translate([3*xoff + 3.5 - scale_map_x[6], 45 - 3*0.555*yoff, 0])  
    cube([w, 70, h], center=true);

  translate([3*xoff + 10, 36 - 3*yoff, 0])  
  rotate([0,0,60])
    cube([w, 20, h], center=true);

  translate([xoff + 10, 33 - 3*yoff, 0])  
  rotate([0,0,60])
    cube([w, 4.2*xoff, h], center=true);

  translate([-xoff*0.5, 0, 0])  
  rotate([0,0,40])
    cube([w, xoff, h], center=true);

  translate([4*xoff-6, -2.25*yoff, 0])  
  rotate([0,0,-90])
    cube([w, 12, h], center=true);
}

module print_plate_left() {
  difference() {
    plate(xoff, yoff, 6);
    switches(xoff, yoff);
  }
}

module left_part1() {
  difference() {
    translate([0,0, -7.85])
      plate(xoff, yoff, 0.5, 40);

    switches(xoff, yoff);
	
    translate([0,0,-7])
      row_connections();
  }
}

module left_part2() {
  color([1,0,0])
  translate([0,0,-8])
    row_connections();
}

module left_part3() {
  difference()
    {
      translate([0,0, -7.5])
	plate(xoff, yoff, 0.5, 35);

	switches(xoff, yoff);
	
	translate([0,0,-7.5])
	col_connections();
    }
}

module left_part4() {
  color([0,1,0])
  translate([0,0,-7.5])
    col_connections();
}

module left_part5() {
  difference() {
    plate(xoff, yoff, 7.5);
    switches(xoff, yoff);
  }  
}

left_part1(); // thickness: 0.5mm, offset: 0mm
left_part2(); // thickness: 0.4mm, offset: 0.1mm
left_part3(); // thickness: 0.5mm, offset: 0.5mm
left_part4(); // thickness: 0.4mm, offset: 0.6mm
left_part5(); // offset: 1mm

module print_plate_right() {
  difference() {
    plate(-xoff, yoff, 7);
    switches(-xoff, yoff);
  }
}

//print_plate_left();
//print_plate_right();

