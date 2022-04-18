include <layout.scad>
include <diode.scad>


module diodes() {
  for(x = [-3:4]) {
    for(y = [-2:1]) {
      if( (x >= 0 || y > -2) && (x<4 || y<0) && (x!=3||y!=-2) ) {

      translate([xoff*x - sign(xoff)*scale_map_x[x+3], yoff*(2+y - 0.5*abs(x)), 0])
	translate([-4, 1.5,-5])
	rotate([0,0,90])
	diode();
      }
    }
  }
}

module connector1(l=10, r=30) {
  translate([-3,-5,0])
  rotate([0,0,r])
  circle(d=6.0, $fn=6);

  translate([-4,1.5,0])
  rotate([0,0,90])
  diode_pads();  
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
        translate([-39.5,-13, 0])
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
	  }
	}
      }
  }

  // y == 0
  translate([-34,-10, 0])
    rotate([0,0,-60])
    square([w, 75], center=true);

  let(x = 0) {
    translate([x*xoff - sign(xoff)*scale_map_x[x+3], x*0.5*yoff, 0])
      connector1();
  }

  translate([37,-13, 0])
    rotate([0,0,62])
    square([w, 91], center=true);

  for(x = [1:2]) {
    translate([x*xoff - sign(xoff)*scale_map_x[x+3], -x*0.5*yoff, 0])
      connector1(8.5);
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
	{
	connector1(30, 40);


	rotate([0,0,-30])
	translate([-16,1])
	  square([11, 4]);
	}
    }

    let( y = 0 ) {
      translate([x*xoff - sign(xoff)*scale_map_x[x+3], (y-x*0.5)*yoff, 0])
      union() {
	connector1(10, 90);

	translate([-35,5,0])
	union() {
	  square([32, 4]);

	  rotate([0,0,61])
	  union() {
	    square([4, 50]);

	    translate([0,50,0])
	      rotate([0,0,-30])
	      square([4, 18]);
	  }
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
    translate([0, 0, -8.5])
      plate(xoff, yoff, 1, 40);

    switches(xoff, yoff);
    diodes();
    
    translate([0,0,-8.5-0.39])
      col_connections();
  }
}

module left_part2() {
  color([1,1,0])
  translate([0,0, -8.5-0.39])
    col_connections();
}

module left_part3() {
  difference()
    {
      translate([0,0, -7.5])
	plate(xoff, yoff, 1, 35);

	switches(xoff, yoff);
	diodes();

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
    diodes();
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
