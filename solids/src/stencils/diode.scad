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

module diode() {
  rotate([0,90,0])
  scale([1.5,1,1])
  union() {
    cylinder(5, d=2, center=true, $fn = 32);
    cylinder(10, d=1, center=true, $fn = 32);
  }

  translate([-4.5, 0,-10])
    cylinder(10, d=2, $fn=6);

  translate([4.5, 0,-10])
    cylinder(10, d=2, $fn=6);
}


include <../layout/positions.scad>

module diodes(s) {
  for(pos = switch_positions(xoff, yoff, s)) {
    translate(pos[1])
      translate([-4, 1.5,-5.7])
      rotate([0,0,90])
      diode();    
  }
}


