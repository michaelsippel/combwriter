include <layout.scad>
include <diode.scad>

pin_off = 2.54;

module pin_header(n=7, off=pin_off) {
  for(x = [0:(n-1)]) {
    
    translate([x*off, 0, 6-3.75])
      cube([1.2, 1.2, 12], center=true);

    translate([x*off, 0, 0])
      cube([2.6, 2.6, 2.5], center=true);

    translate([x*off, 0, 4+1.25])
      cube([2.66, 2.66, 8 ], center=true);
  }
}

module pin_headers() {
  translate([-8.9, 73,-5.5])
    pin_header(7);

  translate([-75,8,-5])
    rotate([0,0,-60])
    pin_header(4);
}

module diodes() {
  for(x = [-3:4]) {
    for(y = [-2:1]) {
      	if( x >= 3 && y < -1 ) {
	  translate([xoff*x + sign(x)*scale_map_x[x+3], yoff*(1.8+y - 0.5*abs(x)), 0])
	    translate([-4, 1.5,-5])
	    rotate([0,0,90])
	    diode();
	    } else

      if( (x >= 0 || y > -2) && (x<4 || y<0) && (x<3||y!=-1) ) {

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
        translate([-31,-8, 0])
	rotate([0,0,-60])

	  square([w, 68], center=true);

	for(x = [-3:0]) {
	  translate([x*xoff - sign(xoff)*scale_map_x[x+3], x*0.5*yoff, 0])
	  connector1();
	}

	if(y > 1)
	  {
	translate([24,-7, 0])
	  rotate([0,0,60])
	  square([w, 63], center=true);
	  }
	else
	  {
	    translate([16,-2.5, 0])
	  rotate([0,0,60])
	      square([w, 45], center=true);
}

	for(x = [1:3]) {
	  translate([x*xoff - sign(xoff)*scale_map_x[x+3], -x*0.5*yoff, 0])
	  union() {
	    connector1(8.5);
	  }
	}
      }
  }

  // y == 0
  translate([-27,-6.6, 0])
    rotate([0,0,-60])
    square([w, 60], center=true);

  let(x = 0) {
    translate([x*xoff - sign(xoff)*scale_map_x[x+3], x*0.5*yoff, 0])
      connector1();
  }

  translate([20,-4, 0])
    rotate([0,0,62])
    square([w, 52], center=true);

  translate([42,-20, 0])
    square([w, 10], center=true);

  translate([55,-30, 0])
    rotate([0,0,65])
    square([w, 30], center=true);
  
  for(x = [1:2]) {
    translate([x*xoff - sign(xoff)*scale_map_x[x+3], -x*0.5*yoff, 0])
      connector1(8.5);
  }

  let( x = 3 ) {
  translate([x*xoff - sign(xoff)*scale_map_x[x+3], (0.5-2.2)*yoff, 0])
    connector1();
  }

  let(x = 4) {
    let(y = -2) {
      translate([x*xoff - sign(xoff)*scale_map_x[x+3], -2.2*yoff, 0])
	connector1();
    }
    /*
    translate([x*xoff - sign(xoff)*scale_map_x[x+3], 26 - 3*yoff, 0])
      translate([5,0,0])
      square([w, 25], center=true);
    */
  }


  translate([-75, 8,-5])
    rotate([0,0,120])
    union() {
    translate([8, -16.2, 0])
      rotate([0,0, 34])
      square([2.5, 28], center=true);

    translate([-2.5, -12, 0])
      rotate([0,0, 0])
      square([2.2, 7], center=true);

    
    translate([-11, -6.4, 0])
      rotate([0,0, 90])
      square([2.2, 13.5], center=true);


    translate([-9.6, -2, 0])
      rotate([0,0, 90])
      square([4, 6], center=true);

    translate([-13.8, 2.5, 0])
      rotate([0,0, 30])
      square([4, 12], center=true);

    translate([-23, 7, 0])
      rotate([0,0, 90])
      square([4, 16], center=true);

    translate([-33, 1, 0])
      rotate([0,0, -30])
      square([4, 15], center=true);

 
    for(x = [-2:1]) {
      translate([(x-1)*pin_off, 0]) {

	translate([0, -4+abs(x)*1.5])
	  square([1.7, 9-abs(x)*3], center=true);
      }
    }

  }  
  }
}

module col_connections(w=3.5, h=0.4) {
  linear_extrude(h)
  union()
  {
    for(x = [-3:-1]) {
      translate([5+x*xoff - sign(xoff)*scale_map_x[x+3], 36 + x*0.5*yoff, 0])
	square([w, 42], center=true);

      for(y = [1:3]) {
	translate([x*xoff - sign(xoff)*scale_map_x[x+3], (y+x*0.5)*yoff, 0])
	connector2();
      }
    }
    
  for(x = [0:2]) {
    translate([5+x*xoff - sign(xoff)*scale_map_x[x+3], 25 - x*0.5*yoff, 0])
      square([w, 60], center=true);

    for(y = [0:3]) {
      translate([x*xoff - sign(xoff)*scale_map_x[x+3], (y-x*0.5)*yoff, 0])
	connector2();
    }
  }

  let( x = 3 ) {
    translate([5+x*xoff - sign(xoff)*scale_map_x[x+3], 36 - x*0.5*yoff, 0])
      square([w, 40], center=true);

    translate([14+x*xoff - sign(xoff)*scale_map_x[x+3], 1-x*0.5*yoff, 0])
      rotate([0,0, 30])
      square([w, 39], center=true);

    for(y = [2:3]) {
      translate([x*xoff - sign(xoff)*scale_map_x[x+3], (y-x*0.5)*yoff, 0])
	connector2();
    }

    let(y = 1) {
      translate([x*xoff - sign(xoff)*scale_map_x[x+3], (-3.5+1.8)*yoff, 0])
	connector2();
    }
  }
  
  let( x = 4 ) {
    let( y = 0 ) {
      translate([x*xoff - sign(xoff)*scale_map_x[x+3], (-4+1.8)*yoff, 0])
	connector2();

      translate([x*xoff - sign(xoff)*scale_map_x[x+3], (y-0.5*x)*yoff, 0])
      union() {
	translate([-35,5,0])
	union() {
	  square([6, 4]);

	  translate([2,0,0])
	  rotate([0,0, -60])
	  square([12, 4]);

	  translate([8,-11,0])
	  square([11, 4]);

	  translate([19,-11,0])
	  rotate([0,0, 60])
	  square([10, 4]);

	  
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

  translate([-1.3,72, 0]) {

    translate([4.5-3*xoff, -9.5-yoff*1.5, 0])
      rotate([0,0, 0])
      square([2.2, 20], center=true);
    translate([6.5-2*xoff, -10.5-yoff, 0])
      rotate([0,0, -5])
      square([2.2, 17], center=true);
    translate([8.4-xoff, -12-yoff*0.5, 0])
      rotate([0,0, -10])
      square([2.2, 15], center=true);

    translate([2.9, -12, 0])
      rotate([0,0, 30])
      square([1.5, 12], center=true);
    translate([3.5+xoff, -11-yoff*0.5, 0])
      rotate([0,0, 30])
      square([2.2, 15], center=true);
    translate([2.7+2*xoff, -10-yoff, 0])
      rotate([0,0, 30])
      square([2.2, 18], center=true);
    translate([2.2+3*xoff, -8.2-yoff*1.5, 0])
      rotate([0,0, 30])
      square([2.2, 20], center=true);

    for(x = [-3:3]) {
      translate([x*pin_off, 0]) {    
	
	translate([0, -3+abs(x)*1.25])
	  square([1.7, 9-abs(x)*2.5], center=true);

	if( x != 0 ) {
	  for(i = [0:abs(x)-1]) {
	    translate([sign(x)*i*xoff, -i*yoff*0.5, 0])
	      union() {
	      translate([1.4*x+sign(x)*1.1, -9])
		rotate([0,0,180 + 30*sign(x)])
		translate([0, 3.5-abs(x)*2.8])
		square([1.7, 12], center=true);

	      if( x > 0 || i<abs(x)-1 ) {

		 if( i == 0 && x == 1 )
		 {
		   translate([sign(x)*10.5, abs(x)*2.5 -17])
		     rotate([0, 0, 90])
		     square([2, 10.6], center=true);
	         }
		 else if( i == 1 && x == 2 )
		 {
		   translate([sign(x)*8.5, abs(x)*2.5 -17])
		     rotate([0, 0, 90])
		     square([1.7, 6.5], center=true);
		 }
		 else if( i == 2 && x == 3 )
		 {
		   translate([sign(x)*6.8, abs(x)*2.5 -17])
		     rotate([0, 0, 90])
		     square([1.7, 3.2], center=true);
		 }
		 else
		 {
		   translate([sign(x)*11.8, abs(x)*2.5 -17])
		     rotate([0, 0, 90])
		     square([1.7, 13], center=true);
		 }
	      }
	    }
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
    translate([0, 0, -7.5])
      plate(xoff, yoff, 2, 37);

    switches(xoff, yoff);
    diodes();
    pin_headers();
    
    translate([0,0,-7.5-0.39])
      col_connections();
  }
}

module left_part2() {
  color([1,1,0])
  translate([0,0, -7.5-0.39])
    col_connections();
}

module left_part3() {
  difference()
    {
      translate([0,0, -6.5])
	plate(xoff, yoff, 1, 37);

	switches(xoff, yoff);
	diodes();

	pin_headers();

	translate([0,0,-6.5-0.39])
	  row_connections();
    }
}

module left_part4() {
  color([0,1,0])
  translate([0,0,-6.5-0.39])
    row_connections();
}

module left_part5() {
  difference() {
    plate(xoff, yoff, 6.5, 37);
    switches(xoff, yoff);
    diodes();
    pin_headers();
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

  difference() {
    union() {
      left_part1(); // thickness: 1mm, offset: 0mm
      left_part2(); // thickness: 0.4mm, offset: 0.6mm
      left_part3(); // thickness: 0.7mm, offset: 1.2mm
      left_part4(); // thickness: 0.4mm, offset: 1.3mm
      left_part5(); // offset: 1.7mm
    }

    translate([3.6*xoff, -0.6*yoff, 0.5])
      joystick();
  }

module print_plate_right() {
  difference() {
    plate(-xoff, yoff, 7);
    switches(-xoff, yoff);
  }
}

//print_plate_left();
//print_plate_right();


