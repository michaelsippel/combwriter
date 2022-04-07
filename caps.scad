
height_map_x = [ 0.55, 0.4, 0.2, 0.1, 0.3, 0.45, 0.55 ];
height_map_y = [ 0.05, 0.0, 0.15 ];

angle_map_x = [ 10, 10, 8, 0, -15, -10, -10 ];
angle_map_y = [ -10, 4, 15 ];

scale_map_x = [ 0.12, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 ];

thumb_angle_map = [ 5, 5, 3, 0, -15 ];

module print_cap(angleX = 0, angleY = 0, height = 1.0, stretchX = 0) {
  rotate([0,180,0])
    translate([0,0,0.25])
    difference() {
    scale([1.0, 0.9, 1])
      rotate([-angleX, -angleY, 0])
      translate([0,0, -height])
      union() {
      cylinder(h=height, d1=1, d2=0.8, $fn=6);

      translate([-stretchX, 0, 0])
	cylinder(h=height, d1=1, d2=0.8, $fn=6);

      translate([stretchX, 0, 0])
	cylinder(h=height, d1=1, d2=0.8, $fn=6);
    }

    scale([1.5, 1.5, 0.5])
      cube(1.0, true);
  };
};

module proto_cap(angleX = 0, angleY = 0, height = 1.0, stretchX = 0) {
    difference() {
      scale([1.0, 0.9, 1])
      union() {
	cylinder(h=height, d1=1, d2=0.8, $fn=6);

	translate([-stretchX, 0, 0])
	  cylinder(h=height, d1=1, d2=0.8, $fn=6);

	translate([stretchX, 0, 0])
	  cylinder(h=height, d1=1, d2=0.8, $fn=6);
      }

      translate([0,0, height])
      rotate([angleX, angleY, 0])
	scale([1.5, 1.5, 0.5])
	cube(1.0, true);
    };
};

module key(angleX, angleY, height, stretchX, proto) {
  if( proto )
    proto_cap(angleX, angleY, height, stretchX);
  else
    print_cap(angleX, angleY, height, stretchX);
};

module main_cluster( proto=false, xoff=1.0, yoff=1.2 ) {
  for(x = [-3:3])
    for(y = [-1:1]) {
      if(x < 3 || y >= 0) {
	
	if( x== 0 && y == 1) {
	  // special treatment for top key in center column
	  translate([0, 3*yoff, 0])
	    key( 20, 0, 0.8, 0.0, proto );
        } else {
	    translate([xoff * x - scale_map_x[x+3], yoff*(2+y - 0.5*abs(x)), 0])
	      key(angle_map_y[y+1],
		  angle_map_x[x+3],
		  0.4 + height_map_x[x + 3] + height_map_y[y + 1],
		  scale_map_x[x+3],
		  proto);
	}
      }
    }
}

module thumb_joystick() {
  union() {
    cylinder(d=0.8, h=0.1, $fn=32);

    translate([0,0,0.35])
      scale([1, 1, 0.3])
      sphere(0.3, $fn=32);

    translate([0,0,0.1])
      scale([1, 1, 0.5])
      sphere(0.4, $fn=32);
  }
}

module thumb_cluster( proto=false, xoff=1.0, yoff=1.2 ) {  
  for(x = [0:4])
    translate([xoff*x, -yoff*(x - 0.5*abs(x)), 0])
      if(x == 3) {
	if( proto )
	  thumb_joystick();
      }
      else
	key(15, thumb_angle_map[x], 0.6+0.5*height_map_x[x], 0.0, proto);

  translate([3*xoff, -0.5*yoff, 0])
  for(x = [0:1])
    translate([xoff*x, -yoff*(x - 0.5*abs(x)), 0])
      key(15, -x*15, 0.8 + x*0.05, 0.0, proto);
}

module plate(xoff, yoff, height=0.1) {
  for(x = [-3:4])
    for(y = [-2:1]) {
      if( (x >= 0 || y > -2) && (x<4 || y<0) ) {
	translate([xoff*x, yoff*(2+y - 0.5*abs(x)), -height])
	  {
	    cylinder(h=height, d=1.3, $fn=6);

	    if( x == -3 )
	      translate([-2*scale_map_x[0], 0, 0])
		cylinder(h=height, d=1.3, $fn=6);
	  }
      }
    }
}

module proto_board() {
  xoff = 0.79;
  yoff = 0.81;
  
  main_cluster(true, xoff, yoff);

  color([0.6, 0, 0])
    thumb_cluster(true, xoff, yoff);

  color([0,0.5,0])
    plate(xoff, yoff);
}

module keycaps() {
  main_cluster();
  thumb_cluster();
}


scale(2.33) {
  proto_board();
  //keycaps();
}

 
