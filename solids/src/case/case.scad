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
//s=1;
angle=[
       0,0
];

include <../layout/positions.scad>
include <../layout/layout.scad>
include <../stencils/joystick.scad>

module esp32c3_board() {
  translate([-16,-24,0])
    {
    difference()
    {
      cube([32, 48, 22]);

      translate([0, 0, 0])
      cube([32, 8, 1.3]);

      translate([0, 0, 1.3+2])
      cube([2, 20, 5]);

      translate([6, 0, 1.3+2])
      cube([2, 13, 5]);
      /*
      translate([25-1.3, 0, 1.3+2])
	cube([2, 13, 5]);
      */
    }

    translate([27, 2.5, -10])
    color([1,0,0])
      cylinder(h=50, d=1.5, $fn=64, center=true);
    }
}

module usb_port_stencil() {
  translate([0, 22.5, 17])
  hull()
    {
      translate([0, 0,0])
	cube([11, 0.1, 7], center=true);

      translate([0, 4, 0])
      cube([12, 0.1, 8], center=true);

      translate([0,20,0])
      cube([12, 0.1, 8], center=true);
    }
}

module comm_jack()
{
  add_height=4;
  add_width=5;
  add_depth=8;

  translate([-3.5, -9-add_depth, -4])
    cube([14+add_width, 18+add_depth, 8+add_height]);

  translate([0,5.5 -18/2,0])
  cube([14, 18, 8], center=true);

  translate([-7-3.5, 0,0])
  rotate([0, 90, 0])
  cylinder(d=6.2, h=3.5, $fn=64);

  translate([-7-3.5, 0,0])
  rotate([0, 90, 0])
  cylinder(d=10, h=2.5, $fn=64);
}

difference()
    {
      // hull

      d=50;
      height=1;

      hw=xoff*5;

      translate([-s*hw,0,0])
	union()
	{

	    translate([(5+4)*s*xoff, 0.5*yoff, 0])
	    {
	      difference()
	      {
		cylinder(h=height+32, d=25, $fn=6);

		mirror([s,0,0])
		color([1,0,0])
		translate([31,-24,20])
		rotate([-10,-30,30])
		  cube([50, 50, 80], center=true);
	      }
	    }

	  for( pos = concat([
		      for(x = [-3:4])
			for(y = [-1:1])
			    [[x,y], [s*xoff * x - s*scale_map_x[x+3], yoff*(2+y - 0.5*abs(x)), 0]]
			     ],
			    switch_positions_thumb(xoff,yoff,s)
			    )
	       )
	    hull()
	      {
		for(x = [0:12])
		  {
		    translate([0,0,0.8*x])
		      rotate([angle[0]*(x/11),-s*angle[1]*(x/11),0])
		      {
			translate([s*hw,0,0])
			  translate(pos[1])
			  {
			    cylinder(h=height, d=d, $fn=6);

			    translate([-s*scale_map_x[pos[0][0]+3], 0,0])
			      cylinder(h=height, d=d, $fn=6);
			  }
		      }
		  }
	      }

	  hull()
	    {
	      for(x = [0:12])
		translate([0,0,0.8*x])
		  rotate([angle[0]*(x/11),-s*angle[1]*(x/11),0])
		  translate([s*hw,0,0])
		  translate([s*xoff*3, -yoff*0.5, 0])
		  {
		    cylinder(h=height, d=d, $fn=6);

		    translate([s*xoff, -yoff*0.5, 0])
		      cylinder(h=height, d=d, $fn=6);
		  }
	    }
	}

      // real plate
      translate([-s*2, -2, 44])
	rotate([angle[0], -s*angle[1], 0])
	union()
	{
	  color([1,1,1])
	    plate(xoff, yoff, s, 40, 39);

	  translate([0,0,-33])
	    if(s == 1)
	      mirror([1,0,0])
		translate(joystick_position_right)
		rotate([0,0,180])
		joystick();
	    else
	      translate(joystick_position_right)
		rotate([0,0,180])
		joystick();
	}

      {
	m = (s+1)/2;

	mirror([m,0,0])
	  {

	    //<<
	    // cables
	    //>>

	    translate([-25.5, 0, 1])
	      cube([130, 10,50]);

	    translate([-12, 30])
	      rotate([0,0,60])
	      translate([-30,0,1])
	      cube([90, 20,50]);

	    translate([-92,30, 1])
	      rotate([0,0,-30])
	    cube([80, 20,50]);

	    
	    //<<
	    // board
	    //>>

	    translate([-4.2*xoff, 1.2*yoff, 18])
	      rotate([0,-90,0])
	      union()
	      {
		color([0,1,0])
		  esp32c3_board();

		  color([0,1,1])
		  usb_port_stencil();

		  /*
		rotate([0,0,-30])
		  translate([-24, 0,19])
		  color([1,1,0])
		  comm_jack();
		*/
	      }
	  }
      }
    }

