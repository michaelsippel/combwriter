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

module text_cap(angleX, angleY, height, t) {
  p = 0.5 * (height - 30);

  translate([0,0, -cos(180-angleY)*p])
  rotate([0, 180-angleY, 0])
  translate([0,0, p])
  rotate([0, angleY, 0])
  
  translate([0,0, -cos(angleX)*p])
  rotate([-angleX, 0, 0])
  translate([0,0, p])
  rotate([angleX, 0, 0])

  translate([0,0,-0.2])
  linear_extrude(0.2)
  union() {
    translate([0, 3.5,0])
      text(t[0][0], size=5, valign="center", halign="center", font="Fira Code SemiBold");

    translate([2.5, -3.5,0])
      text(t[0][1], size=4.8, valign="center", halign="center", font="Fira Code");

    translate([-2.5,-3.5,0])
      text(t[0][2], size=4.8, valign="center", halign="center", font="Fira Code");
  }
}

module print_cap(angleX = 0, angleY = 0, height = 1.0, stretchX = 0, t="A") {
  difference() {
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

    text_cap(angleX, angleY, height, t);
  }
}

module proto_cap(angleX = 0, angleY = 0, height = 1.0, stretchX = 0, t="A") {
  difference() {
    base_cap(height, stretchX);
      translate([0,0, height])
	rotate([angleX, angleY, 0])
	scale([1.5, 1.5, 0.5])
	cube(20.0, true);
  }
}

module key(angleX=0, angleY=0, height=20, stretchX=0, proto=false, t="") {
  if( proto )
    proto_cap(angleX, angleY, height, stretchX, t);
  else
    print_cap(angleX, angleY, height, stretchX, t);
}

