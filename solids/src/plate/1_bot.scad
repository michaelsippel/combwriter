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

difference() {
  translate([0, 0, -7.8])
    plate(xoff, yoff, s, 2, 37);

  switches(xoff, yoff, s);
  diodes(s);

  pin_headers(s);
  translate([0,0,-7.8-0.5])
    {
      if(s == 1)
	col_connections_left();
      else
	col_connections_right();
    }
}
