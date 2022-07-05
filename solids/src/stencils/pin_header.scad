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

pin_off = 2.54;

module pin_header(n=7, off=pin_off) {
  for(x = [0:(n-1)]) {

    translate([x*off, 0, 1.8])
      cube([1.5, 1.5, 12], center=true);

    translate([x*off, 0, 0])
      cube([2.6, 2.75, 2.5], center=true);

    translate([x*off, 0, 4+1.25])
      cube([2.66, 2.75, 8 ], center=true);
  }
}

module pin_headers(s) {
  translate([-8.7, 72.6, -5.5])
    pin_header(7);

mirror([max(-s,0), 0, 0])
  translate([-74.6,8.5,-5])
    rotate([0,0,-60])
    pin_header(4);
}

