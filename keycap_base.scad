include <mx_switch.scad>

module base_cap(height, stretchX, d=23) {  
  scale([1, 0.95, 1])
  union() {
    cylinder(h=height, d1=d, d2=0.8 * d, $fn=6);

    translate([-stretchX, 0, 0])
      cylinder(h=height, d1=d, d2=0.8 * d, $fn=6);

    translate([stretchX, 0, 0])
      cylinder(h=height, d1=d, d2=0.8 * d, $fn=6);
  }
}

module print_cap(angleX = 0, angleY = 0, height = 1.0, stretchX = 0) {
  rotate([0,180,0])
  translate([0,0,5])
  difference() {
    rotate([-angleX, -angleY, 0])
    translate([0,0, -height])
    difference() {
        base_cap(height, stretchX);

	translate([0,0, -2])
	mx_switch();
    }

    scale([1.5, 1.5, 0.5])
    cube(20.0, true);
  }
}

module proto_cap(angleX = 0, angleY = 0, height = 1.0, stretchX = 0) {
  difference() {
    base_cap(height, stretchX);

    translate([0,0, height])
    rotate([angleX, angleY, 0])
    scale([1.5, 1.5, 0.5])
    cube(20.0, true);
  }
}

module key(angleX=0, angleY=0, height=20, stretchX=0, proto=false) {
  if( proto )
    proto_cap(angleX, angleY, height, stretchX);
  else
    print_cap(angleX, angleY, height, stretchX);
}

