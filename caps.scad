
xoff = 0.78;
yoff = 0.9;

module key(
    angleX = 0,
    angleY = 0,
    height = 1.0,
) {
    difference() {
      cylinder(h=height, d1=1, d2=0.8, $fn=6);

      translate([0,0, height])
	rotate([angleX, angleY, 0])
	scale([1.5, 1.5, 0.5])
	cube(1.0, true);
    };
};

module main_cluster() {
  for(x = [-3:3])
    for(y = [-1:1]) {
      if(x < 3 || y >= 0) {
	translate([xoff*x, yoff*(2+y - 0.5*abs(x)), 0])
	  //scale([1.0, 0.8+abs(y)*0.2,1])
	  key(y*15, -x*5, 0.3 + abs(y)*0.15 + abs(x)*0.15);
      }
    }
}

module thumb_joystick() {
  union() {
    cylinder(d=0.8, h=0.2, $fn=32);

    translate([0,0,0.48])
      scale([1, 1, 0.3])
      sphere(0.3, $fn=32);

    translate([0,0,0.2])
      scale([1, 1, 0.6])
      sphere(0.4, $fn=32);
  }
}

module thumb_cluster() {
  for(x = [0:4])
    translate([xoff*x, -yoff*(x - 0.5*abs(x)), 0])
      if(x == 3)
	thumb_joystick();
      else
	key(10, -(x-2)*5, 0.7);

  translate([3*xoff, -0.5*yoff, 0])
  for(x = [0:1])
    translate([xoff*x, -yoff*(x - 0.5*abs(x)), 0])
      key(10, -x*5, 0.8);
}

module plate(height=0.1) {
  for(x = [-3:4])
    for(y = [-2:1]) {
      if( (x >= 0 || y > -2) && (x<4 || y<0) ) {
	translate([xoff*x, yoff*(2+y - 0.5*abs(x)), -height])
	  cylinder(h=height, d=1.3, $fn=6);
      }
    }
}

main_cluster();

color([0.6, 0, 0])
thumb_cluster();

color([0,0.5,0])
plate();

