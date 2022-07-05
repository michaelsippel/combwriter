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

include <../stencils/matrix_left.scad>
include <../stencils/matrix_right.scad>
include <../stencils/pin_header.scad>
include <../stencils/diode.scad>
include <../stencils/joystick.scad>

difference()
{
  difference() {
    translate([0,0,-6.0])
    plate(xoff, yoff, s, 0.5, 37);

    switches(xoff, yoff, s);
    diodes(s);
    pin_headers(s);
  }

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
