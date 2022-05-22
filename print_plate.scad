include <layout.scad>
include <diode.scad>
include <matrix_left.scad>
include <matrix_right.scad>
include <pin_header.scad>

pin_off = 2.54;

module part1(s) {
  difference() {
    translate([0, 0, -7.8])
      plate(xoff, yoff, s, 2, 37);

    switches(xoff, yoff, s);
    diodes(s);

    pin_headers(s);
    translate([0,0,-7.8-0.5])
    {
      if(s == 1)
	col_connections_left();
      else
	col_connections_right();
    }
  }
}

module part2(s) {
  color([1,1,0])
  translate([0,0, -7.8-0.5])
      if(s == 1)
	col_connections_left();
      else
	col_connections_right();
}

module part3(s) {
  difference()
    {
      translate([0,0, -6.5])
	plate(xoff, yoff, s, 1.25, 37);

      switches(xoff, yoff, s);
	diodes(s);
	pin_headers(s);

	translate([0,0,-6.6-0.6])
      if(s == 1)
	row_connections_left();
      else
	row_connections_right();
    }
}

module part4(s) {
  color([0,1,0])
  translate([0,0,-6.6-0.6])
    if(s == 1)
      row_connections_left();
    else
      row_connections_right();
}

module part5(s) {
  difference() {
    translate([0,0,-6.0])
    plate(xoff, yoff, s, 0.5, 37);

    switches(xoff, yoff, s);
    diodes(s);
    pin_headers(s);
  }
}

module part6(s) {
  difference() {
    plate(xoff, yoff, s, 6.0, 37);
    switches(xoff, yoff, s);
    diodes(s);
    pin_headers(s);
  }
}

module joystick() {
  difference() {
    union() {
      cube([41,22,15], center=true);

      translate([20,0,0])
      cylinder(15, d=4.5, center=true, $fn=64);
      translate([-10,-10,0])
      cylinder(15, d=4, center=true, $fn=64);
      translate([-10,10,0])
      cylinder(15, d=4.5, center=true, $fn=64);

      translate([20,0,0])
      cylinder(30, d=1.3, center=true, $fn=64);
      translate([-10,-10,0])
      cylinder(30, d=1.3, center=true, $fn=64);
      translate([-10,10,0])
      cylinder(30, d=1.3, center=true, $fn=64);
    }

    translate([-20,0,0])
      cylinder(15, d=4, center=true, $fn=64);

    translate([10, -10.3, 0])
      cylinder(15, d=4, center=true, $fn=64);
    translate([10, 10.3, 0])
      cylinder(15, d=4, center=true, $fn=64);
  }  
}

module print_plate(s) {
  difference() {
    union() {
      //part1(s);
      //part2(s);
      //part3(s);
      //part4(s);
      //part5(s);
      //part6(s);
    }

    if(s == -1)
    translate([-3.6*xoff, -0.6*yoff, 0.5])
      rotate([0,0,180])
      joystick();
    if(s == 1)
    translate([3.6*xoff, -0.6*yoff, 0.5])
      joystick();
  }
}  
/*
translate([-100,0,0])
print_plate(1);

translate([100,0,0])
print_plate(-1);
*/
