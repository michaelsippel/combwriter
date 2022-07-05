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

include <../layout/layout.scad>
include <diode.scad>
include <matrix_left.scad>
include <matrix_right.scad>
include <pin_header.scad>

module joystick() {
  difference() {
    union() {
      cube([41,22,15], center=true);

      translate([20,0,0])
      cylinder(15, d=4.5, center=true, $fn=64);
      translate([-10,-10,0])
      cylinder(15, d=4, center=true, $fn=64);
      translate([-10,10,0])
      cylinder(15, d=4.5, center=true, $fn=64);

      translate([20,0,0])
      cylinder(30, d=1.3, center=true, $fn=64);
      translate([-10,-10,0])
      cylinder(30, d=1.3, center=true, $fn=64);
      translate([-10,10,0])
      cylinder(30, d=1.3, center=true, $fn=64);
    }

    translate([-20,0,0])
      cylinder(15, d=4, center=true, $fn=64);

    translate([10, -10.3, 0])
      cylinder(15, d=4, center=true, $fn=64);
    translate([10, 10.3, 0])
      cylinder(15, d=4, center=true, $fn=64);
  }  
}

