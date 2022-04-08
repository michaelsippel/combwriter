
module mx_switch() {
  union() {

    // cross
    translate([0,0,3])
      cube([4.0, 1.2, 4.0], center=true);

    difference() {
      translate([0,0,3])
	cube([1.0, 4.0, 4.0], center=true);

      translate([0,2.0,4.25])
	cube([2.0,0.8,0.6], center=true);
    }

    cube([7.0,6.0, 4.0], center=true);

    // upper half
    difference() {
      hull() {
	translate([0,0.5,5])
	  cube([14.5, 9, 0.01], center=true);

	cube([14.5, 14, 0.01], center=true);
      }

      translate([0,0,3])
      cube([6,5,6], center=true);
    }

    // lower half
    translate([0,0, -0.5])
      cube([14.5, 16.5, 1.0], center=true);

    translate([0,0, -1.0])
      cube([14.5, 13.7, 2.0], center=true);

    difference() {
      translate([0,0, -4.0])
      cube([14.5, 14.5, 4.0], center=true);

      translate([0, 5, -5])
      cube([1.5, 1.5, 2.5], center=true);
    }

    translate([0,0, -10])
      cylinder(h=5, d=4, $fn=32);

    translate([3, -2.5, -10])
      cylinder(h=5, d=2, $fn=32);

    translate([-3.0, -5, -10])
      cylinder(h=5, d=2, $fn=32);
  }
}

