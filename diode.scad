
module diode() {
  rotate([0,90,0])
  scale([1.5,1,1])
  union() {
    cylinder(5, d=2, center=true, $fn = 32);
    cylinder(10, d=1, center=true, $fn = 32);
  }

  translate([-4.5, 0,-10])
    cylinder(10, d=1.5, $fn=32);

  translate([4.5, 0,-10])
    cylinder(10, d=1.5, $fn=32);
}

module diode_pads() {
  translate([-4.5, 0,-10])
    circle(d=3.0, $fn=6);

  translate([4.5, 0,-10])
    circle(d=3.0, $fn=6);
}


