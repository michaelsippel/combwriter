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

module mx_switch() {
  union() {

    // cross
    translate([0,0,3])
      cube([4.0, 1.2, 5.0], center=true);

    difference() {
      translate([0,0,3])
	cube([1.0, 4.0, 5.0], center=true);

      translate([0,2.0,4.75])
	cube([2.0,0.5,0.6], center=true);

    }

    cube([7.0,6.0, 4.0], center=true);

    // upper half
    difference() {
      hull() {
	translate([0,0.5,5.5])
	  cube([13, 11, 0.01], center=true);

	cube([13, 15, 0.01], center=true);
      }

      translate([0,0,3])
      cube([6,5,6], center=true);
    }

    // lower half
    translate([0,0, -0.5])
      cube([14.5, 16.5, 1.0], center=true);

    translate([0,0, -1.0])
      cube([14.5, 13.7, 2.0], center=true);

    difference() {
      translate([0,0, -4.0])
      cube([14.5, 14.5, 4.0], center=true);

      translate([0, 5, -5])
      cube([1.5, 1.5, 2.5], center=true);
    }

    translate([0,0, -10])
      cylinder(h=5, d=4, $fn=32);

    translate([3.5, -2.7, -10])
      cylinder(h=5, d=2, $fn=6);

    translate([-3.0, -5, -10])
      cylinder(h=5, d=2, $fn=6);
  }
}

