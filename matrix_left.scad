include <connectors.scad>

module row_connections_left(w=3.5, h=0.6) {
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
      square([4, 5.5], center=true);

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
	  square([1.5, 9-abs(x)*3], center=true);
      }
    }

  }  
  }
}

module col_connections_left(w=3.5, h=0.5) {
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
	  square([1.6, 9-abs(x)*2.5], center=true);

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
		     square([1.5, 10.6], center=true);
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
		     square([1.5, 13], center=true);
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

