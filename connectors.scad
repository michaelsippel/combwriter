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

module diode_pads() {
  translate([-4.5, 0,-10])
    circle(d=3.0, $fn=6);

  translate([4.5, 0,-10])
    circle(d=3.0, $fn=6);
}

module connector1(l=10, r=30) {
  translate([-3,-5,0])
  rotate([0,0,r])
  circle(d=6.0, $fn=6);

  translate([-4,1.5,0])
  rotate([0,0,90])
  diode_pads();  
}

module connector2() {
  translate([3.4,-2.8,0])
    circle(2.0, $fn=6);
}

