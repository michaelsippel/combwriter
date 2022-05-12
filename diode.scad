
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


include <layout.scad>

module diodes(s) {
  for(pos = switch_positions(xoff, yoff, s)) {
    translate(pos[1])
      translate([-4, 1.5,-5])
      rotate([0,0,90])
      diode();    
  }
}


