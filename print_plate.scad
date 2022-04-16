include <layout.scad>

module connector1(l=10, r=30) {
  translate([-3,-5,0])
  rotate([0,0,r])
  union() {
    circle(d=6.0, $fn=6);
    translate([0,l/2,0])
    square([4, l], center=true);
  }
}

module connector2() {
  translate([3.4,-2.8,0])
    circle(2.0, $fn=6);
}

module row_connections(w=3.5, h=0.4) {
  linear_extrude(h)
    union() {
  for(y = [1:3]) {
    translate([0, y*yoff, 0])
      union() {
        translate([-39.5,-12.8, 0])
	rotate([0,0,-60])
	square([w, 87], center=true);

	for(x = [-3:0]) {
	  translate([x*xoff - sign(xoff)*scale_map_x[x+3], x*0.5*yoff, 0])
	  connector1();
	}

	translate([24,-7, 0])
	  rotate([0,0,60])
	  square([w, 63], center=true);

	for(x = [1:3]) {
	  translate([x*xoff - sign(xoff)*scale_map_x[x+3], -x*0.5*yoff, 0])
	  union() {
	    connector1(8.5);
	    translate([-5.5,4,0])
	    rotate([0,0,-30])
	      square([3,7], center=true);
	  }
	}
      }
  }

  // y == 0
  translate([-33.5,-9.5, 0])
    rotate([0,0,-60])
    square([w, 75], center=true);

  for(x = [0:0]) {
    translate([x*xoff - sign(xoff)*scale_map_x[x+3], x*0.5*yoff, 0])
      connector1();
  }

  translate([37,-14, 0])
    rotate([0,0,60])
    square([w, 91], center=true);

  for(x = [1:3]) {
    translate([x*xoff - sign(xoff)*scale_map_x[x+3], -x*0.5*yoff, 0])
	  union() {
	    connector1(8.5);
	    translate([-5.2,4,0])
	    rotate([0,0,-30])
	      square([3, 8], center=true);
	  }
  }

  let(x = 4) {
    for(y = [-2:-1]) {
	translate([x*xoff - sign(xoff)*scale_map_x[x+3], y*yoff, 0])
	connector2();
    }

    translate([x*xoff - sign(xoff)*scale_map_x[x+3], 26 - 3*yoff, 0])
      translate([5,0,0])
      square([w, 25], center=true);
  }
  }
}

module col_connections(w=3.5, h=0.4) {
  linear_extrude(h)
  union()
  {
    for(x = [-3:-1]) {
      translate([5+x*xoff - sign(xoff)*scale_map_x[x+3], 47 + x*0.5*yoff, 0])
	square([w, 65], center=true);

      for(y = [1:3]) {
	translate([x*xoff - sign(xoff)*scale_map_x[x+3], (y+x*0.5)*yoff, 0])
	connector2();
      }
  }

  for(x = [0:2]) {
    translate([5+x*xoff - sign(xoff)*scale_map_x[x+3], 35 - x*0.5*yoff, 0])
      square([w, 80], center=true);

    for(y = [0:3]) {
      translate([x*xoff - sign(xoff)*scale_map_x[x+3], (y-x*0.5)*yoff, 0])
	connector2();
    }
  }

  let( x = 3 ) {
    translate([5+x*xoff - sign(xoff)*scale_map_x[x+3], 45 - x*0.5*yoff, 0])
      square([w, 62], center=true);

    for(y = [1:3]) {
      translate([x*xoff - sign(xoff)*scale_map_x[x+3], (y-x*0.5)*yoff, 0])
	connector2();
    }
  }

  let( x = 4 ) {
    let( y = 1 ) {
      translate([x*xoff - sign(xoff)*scale_map_x[x+3], (y-x*0.5)*yoff, 0])
	connector1(15, 40);
    }

    let( y = 0 ) {
      translate([x*xoff - sign(xoff)*scale_map_x[x+3], (y-x*0.5)*yoff, 0])
      union() {
	connector1(10, 90);

	translate([-13,-7,0])
	rotate([0,0,61])
	  union()
	  {
	    square([4, 75]);

	    translate([0,75,0])
		rotate([0,0,-30])
	      square([4, 18]);
	  }
      }
    }
  }
  }
}

module print_plate_left() {
  difference() {
    plate(xoff, yoff, 6);
    switches(xoff, yoff);
  }
}

module left_part1() {
  difference() {
    translate([0,0, -8.2])
      plate(xoff, yoff, 1, 45);

    switches(xoff, yoff);

    translate([0,0,-8.2-0.39])
      col_connections();
  }
}

module left_part2() {
  color([1,1,0])
  translate([0,0,-8.2-0.39])
    col_connections();
}

module left_part3() {
  difference()
    {
      translate([0,0, -7.5])
	plate(xoff, yoff, 0.7, 40);

	switches(xoff, yoff);

	translate([0,0,-7.5-0.39])
	row_connections();
    }
}

module left_part4() {
  color([0,1,0])
  translate([0,0,-7.5-0.39])
    row_connections();
}

module left_part5() {
  difference() {
    plate(xoff, yoff, 7.5);
    switches(xoff, yoff);
  }  
}

left_part1(); // thickness: 1mm, offset: 0mm
//left_part2(); // thickness: 0.4mm, offset: 0.6mm
//left_part3(); // thickness: 0.7mm, offset: 1.2mm
left_part4(); // thickness: 0.4mm, offset: 1.3mm
//left_part5(); // offset: 1.7mm

module print_plate_right() {
  difference() {
    plate(-xoff, yoff, 7);
    switches(-xoff, yoff);
  }
}

//print_plate_left();
//print_plate_right();

