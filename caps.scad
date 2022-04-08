include <mx_switch.scad>

height_map_x = [ 12.65 , 9.2 , 4.6, 2.3, 6.9, 10.36, 12.65 ];
height_map_y = [ 1.15, 0.0, 3.45 ];

angle_map_x = [ 10, 10, 8, 0, -15, -10, -10 ];
angle_map_y = [ -10, 4, 15 ];

scale_map_x = [ 0.12, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 ];

thumb_angle_map = [ 5, 5, 3, 0, -15 ];

module base_cap(height, stretchX, d=23) {  
  scale([1.0, 0.9, 1])
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

	translate([0,0, -0.5])
	mx_switch();
    }

    scale([1.5, 1.5, 0.5])
    cube(20.0, true);
  };
};

module proto_cap(angleX = 0, angleY = 0, height = 1.0, stretchX = 0) {
  difference() {
    base_cap(height, stretchX);

    translate([0,0, height])
    rotate([angleX, angleY, 0])
    scale([1.5, 1.5, 0.5])
    cube(20.0, true);
  };
};

module key(angleX=0, angleY=0, height=20, stretchX=0, proto=false) {
  if( proto )
    proto_cap(angleX, angleY, height, stretchX);
  else
    print_cap(angleX, angleY, height, stretchX);
};

module main_cluster( proto=false, xoff=20, yoff=25 ) {
  for(x = [-3:3])
    for(y = [-1:1]) {
      if(x < 3 || y >= 0) {
	
	if( x== 0 && y == 1) {
	  // special treatment for top key in center column
	  translate([0, 3*yoff, 0])
	    key( 20, 0, 18.4, 0.0, proto );
        } else {
	    translate([xoff * x - scale_map_x[x+3], yoff*(2+y - 0.5*abs(x)), 0])
	      key(angle_map_y[y+1],
		  angle_map_x[x+3],
		  9.2 + height_map_x[x + 3] + height_map_y[y + 1],
		  scale_map_x[x+3],
		  proto);
	}
      }
    }
}

module thumb_joystick() {
  union() {
    cylinder(d=18, h=2.5, $fn=32);

    translate([0,0,2.5])
      scale([1, 1,0.5])
      sphere(d=18, $fn=32);

    translate([0,0,8])
      scale([1, 1, 0.3])
      sphere(d=12, $fn=32);
  }
}

module thumb_cluster( proto=false, xoff=20, yoff=25 ) {  
  for(x = [0:4])
    translate([xoff*x, -yoff*(x - 0.5*abs(x)), 0])
      if(x == 3) {
	if( proto )
	  thumb_joystick();
      }
      else
	key(15, thumb_angle_map[x], 13.8 + 0.5*height_map_x[x], 0.0, proto);

  translate([3*xoff, -0.5*yoff, 0])
  for(x = [0:1])
    translate([xoff*x, -yoff*(x - 0.5*abs(x)), 0])
      key(15, -x*15, 18.4 + x*0.05, 0.0, proto);
}

module switches(xoff, yoff) {
  for(x = [-3:4]) {
    for(y = [-2:1]) {
      if( (x >= 0 || y > -2) && (x<4 || y<0) ) {

	if( ! (x == 3 && y == -2) ) {
	  translate([xoff*x, yoff*(2+y - 0.5*abs(x)), 0])
	    color([1,0,0])
	    translate([0,0,1])
	    mx_switch();
	}
      }
    }
  }
}

module plate(xoff, yoff, height=2, proto=false) {
  for(x = [-3:4]) {
    for(y = [-2:1]) {
      if( (x >= 0 || y > -2) && (x<4 || y<0) ) {
	translate([xoff*x, yoff*(2+y - 0.5*abs(x)), -height])
	  {
	    cylinder(h=height, d=30, $fn=6);

	    if( x == -3 )
	      translate([-2*scale_map_x[0], 0, 0])
		cylinder(h=height, d=30, $fn=6);
	  }
      }
    }
  }
}

module proto_board(xoff = 18.17, yoff = 18.63) {
  main_cluster(true, xoff, yoff);

  color([0.6, 0, 0])
    thumb_cluster(true, xoff, yoff);

  color([0,0.5,0])
    plate(xoff, yoff);
}

module print_plate(xoff = 18.17, yoff = 18.63) {
  difference() {
    plate(xoff, yoff, 7, true);
    switches(xoff, yoff);
  }
}

module print_keycaps() {
  main_cluster();
  thumb_cluster();
}

proto_board();
//print_plate();
//print_keycaps();

