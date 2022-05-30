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

module pin_headers(s) {
  translate([-8.9, 73,-5.5])
    pin_header(7);

mirror([max(-s,0), 0, 0])
  translate([-75,8,-5])
    rotate([0,0,-60])
    pin_header(4);
}

