/*
      Copyright 2022 Michael Sippel

<<<<>>>><<>><><<>><<<*>>><<>><><<>><<<<>>>>

 This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
 License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later
 version.

 This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
 warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 details.

 You should have received a copy of the GNU General Public License along with this program. If not, see
 <https://www.gnu.org/licenses/>.
*/

include <connectors.scad>
include <layout.scad>

module row_connections_right(w=3.5, h=0.6) {
  linear_extrude(h)
  union() {

    for( pos = switch_positions(xoff, yoff, -1) )
      translate(pos[1])
	connector1();

    for(y = [1:3]) {
      translate([0, y*yoff, 0])
	union() {

      	if(y > 1) {
	  translate([-31,-8, 0])
	    rotate([0,0,-60])
	    square([w, 68], center=true);
        }else{
	  translate([-21,-2.5, 0])
	    rotate([0,0, -60])
	    square([w, 45], center=true);
	}

	translate([28.6,-9, 0])
	  rotate([0,0,61.2])
	  square([w, 73], center=true);
      }
    }

  // y == 0

  translate([-68, -32, 0])
    rotate([0, 0, -60])
    square([w, 24], center=true);

  translate([-35, -29, 0])
    rotate([0, 0, -60])
    square([w, 20], center=true);

  translate([-51, -30, 0])
    rotate([0, 0, -114])
    square([w, 19], center=true);

  translate([-27, -17, 0])
    square([w, 16], center=true);
    
  translate([-20,-5, 0])
    rotate([0,0,-60])
    square([w, 45], center=true);

  translate([6, 2, 0])
    rotate([0,0,63])
    square([w, 20], center=true);

  translate([18, -2, 0])
    rotate([0,0,90])
    square([w, 10], center=true);

  translate([25, -7.5, 0])
    rotate([0,0,30])
    square([w, 15], center=true);

  translate([35.5, -13, 0])
    rotate([0,0,90])
    square([w, 16], center=true);

  translate([46, -18, 0])
    rotate([0,0,30])
    square([w, 14], center=true);

  translate([55.5, -23, 0])
    rotate([0,0,90])
    square([w, 14.5], center=true);

  translate([64.6, -18, 0])
    rotate([0,0,-30])
    square([w, 13.5], center=true);

  translate([75, 8, 0])
    rotate([0,0,-120])
    union() {
      translate([-7, -15, 0])
	rotate([0,0, -34])
	square([2.5, 25], center=true);

      translate([2.8, -12, 0])
	rotate([0,0, 0])
	square([2.2, 8], center=true);

      translate([11.5, -6.4, 0])
	rotate([0,0, 91])
	square([2.2, 14.5], center=true);

      translate([9.6, -2, 0])
	rotate([0,0, 90])
	square([4, 5.5], center=true);

      translate([17, 1, 0])
	rotate([0,0, -60])
	square([4, 13], center=true);

      for(x = [-2:1]) {
	translate([-(x-1)*pin_off, 0]) {

	  translate([0, -4+abs(x)*1.5])
	    square([1.5, 9-abs(x)*3], center=true);
	}
      }
    }
  }
}

module col_connections_right(w=3.5, h=0.5) {
  linear_extrude(h)
    union()
    {
      for(pos = switch_positions(xoff, yoff, -1))
	translate(pos[1])
	  connector2();
    
      for(x = [-3:-1]) {
	translate([5-x*xoff + scale_map_x[x+3], 36 + x*0.5*yoff, 0])
	  square([w, 42], center=true);
      }
    
      for(x = [0:2]) {
	translate([5-x*xoff + scale_map_x[x+3], 26 - x*0.5*yoff, 0])
	  square([w, 58], center=true);
      }

      let( x = 3 ) {
	translate([5-x*xoff, 40 - x*0.5*yoff, 0])
	  {
	  square([w, 30], center=true);

	  translate([-9, -30, 0])
	    rotate([0,0, -30])
	    square([w, 37], center=true);
	  
	  translate([-xoff, -2.7*yoff, 0])
	    square([w, 15], center=true);

	  }
      }

      translate([8-3.3*xoff,-1.9*yoff,0])
	union() {
	rotate([0,0,-61])
	  union() {
	  square([4, 78]);
	  translate([0.5,76,0])
	    rotate([0,0,25])
	    square([4, 10]);

	}
      }

      translate([-1.3,72, 0]) {

	translate([5-3*xoff, -8.5-yoff*1.5, 0])
	  rotate([0,0, 0])
	  square([2.2, 19], center=true);
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
	translate([4+3*xoff, -8.2-yoff*1.5, 0])
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
			translate([sign(x)*7.5, abs(x)*2.5 -17])
			  rotate([0, 0, 90])
			  square([1.7, 5], center=true);
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

