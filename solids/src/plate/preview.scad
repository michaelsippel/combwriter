
s=-1;

difference() {
  union() {
    include <1_bot.scad>
      //	include <2_col.scad>
      //	include <3_mid.scad>
      //	include <4_row.scad>
      //	include <5_top1.scad>
      //	include <6_top2.scad>
    }

    if(s == -1)
    translate([-3.6*xoff, -0.65*yoff, 0.5])
      rotate([0,0,180])
      joystick();
    if(s == 1)
    translate([3.6*xoff, -0.65*yoff, 0.5])
      joystick();
  }

