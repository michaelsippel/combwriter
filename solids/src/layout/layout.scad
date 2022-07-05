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

include <../keycaps/base.scad>
include <../stencils/mx_switch.scad>

include <positions.scad>
include <text/neo.scad>

module main_cluster( proto=false, s=1, xoff=20, yoff=30 ) {
  for(pos = switch_positions_main(xoff, yoff, s) ) {
    let( x = pos[0][0], y = pos[0][1] )
      if( x == 0 && y == 1) {
	// special treatment for top key in center column
	translate([0, 3*yoff, 0])
	  key( 20, 0, 18.4, 0.0, proto, get_text(s, x, y) );
      } else if( x == 3 && y == 0 ) {
	translate(pos[1])
	difference() {
	  height = 9.2 + height_map_x[x+3] + height_map_y[y+1];
	  key(angle_map_y[y+1],
	      angle_map_x[s*x+3],
	      height,
	      scale_map_x[x+3],
	      proto,
	      get_text(s, x, y));

	  if( s == -1 )
	    mirror([1,0,0])
	    {
	      translate([0,-10,0])
		rotate([0,-20,60])
		cube([10,40,40], center=true);
	    }
	  else
	    {
	      translate([0,-10,0])
		rotate([0,-20,60])
		cube([10,40,40], center=true);
	    }
	}
      } else {
	translate(pos[1])
	  key(angle_map_y[y+1],
	      angle_map_x[s*x+3],
	      9.2 + height_map_x[x+3] + height_map_y[y+1],
	      scale_map_x[x+3],
	      proto,
	      get_text(s, x, y));
      }
  }
}

module main_cluster_text(s=1, xoff=20, yoff=30) {
  for(pos = switch_positions_main(xoff, yoff, s) ) {
    let( x = pos[0][0], y = pos[0][1] )
      if( x == 0 && y == 1) {
	// special treatment for top key in center column
	translate([0, 3*yoff, 0])
	  text_cap( 20, 0, 18.4, get_text(s, x, y) );
      } else {
	translate(pos[1])
	  text_cap(angle_map_y[y+1],
	      angle_map_x[s*x+3],
	      9.2 + height_map_x[x+3] + height_map_y[y+1],
		   get_text(s, x, y));
      }
  }  
}

module thumb_cluster( proto=false, s=1, xoff=20, yoff=25 ) {
  for(pos = switch_positions_thumb(xoff, yoff, s))
    let( x = pos[0][0], y = pos[0][1] )
      translate(pos[1])
      difference() {
	  key(15, s*thumb_angle_map[x], thumb_height_map[x], 0.0, proto, get_text(3, x));

	  if ( x == 3 && y == -3 ) {
	    if( s == -1 )
	      mirror([1,0,0])
		{
		  translate([0,10,0])
		    rotate([0,-20,-60])
		    cube([10,40,40], center=true);
		}
	    else
	      {
		  translate([0,10,0])
		    rotate([0,-20,-60])
		    cube([10,40,40], center=true);
	      }	      
	  }
      }
}

module plate(xoff, yoff, s=1, height=2, d=30) {
  translate([0,0,-height])
    {
      for(pos = switch_positions(xoff, yoff, s) )
	{
	  translate(pos[1])
	    {
	      cylinder(h=height, d=d, $fn=6);

	      translate([-s*scale_map_x[pos[0][0]+3], 0,0])
		cylinder(h=height, d=d, $fn=6);
	    }
	}

	translate([s*xoff*3, -yoff*0.5, 0])
	{
	  cylinder(h=height, d=d, $fn=6);

	  translate([s*xoff, -yoff*0.5, 0])
	    cylinder(h=height, d=d, $fn=6);

	}
    }
}

module switches(xoff, yoff, s) {
  for(pos = switch_positions(xoff, yoff, s))
    translate(pos[1])
      color([1,0,0])
      translate([0,0,1])
      mx_switch();
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
