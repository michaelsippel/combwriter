include <layout.scad>

module row_connections(w=3, h=0.4) {
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
	translate([15,8,0])
	  rotate([0,0,60])
	  cube([w, 45, h], center=true);

	for(x = [0:2]) {
	  translate([x*xoff - 3 - sign(xoff)*scale_map_x[x+3], -x*0.5*yoff+11, 0])
	    cube([w, 15, h], center=true);
	}
    }
}


module col_connections(w=3, h=0.4) {
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
}

module print_plate_left() {
  difference() {
    plate(xoff, yoff, 6);
    switches(xoff, yoff);
  }
}

module left_part1() {
  difference() {
    translate([0,0, -5.85])
      plate(xoff, yoff, 1);

    switches(xoff, yoff);
	
    translate([0,0,-6])
      row_connections();
  }
}

module left_part2() {
  color([1,0,0])
  translate([0,0,-6])
    row_connections();
}

module left_part3() {
  difference()
    {
      translate([0,0, -4.85])
	plate(xoff, yoff, 1);

	switches(xoff, yoff);
	
	translate([0,0,-5])
	col_connections();
    }
}

module left_part4() {
  color([0,1,0])
  translate([0,0,-5])
    col_connections();
}


module left_part5() {
  difference() {
    plate(xoff, yoff, 5);
    switches(xoff, yoff);
  }  
}

left_part1();
left_part2();
left_part3();
left_part4();
left_part5();


module print_plate_right() {
  difference() {
    plate(-xoff, yoff, 7);
    switches(-xoff, yoff);
  }
}

//print_plate_left();
//print_plate_right();

