include <print_plate.scad>

difference()
{
  part6(-1);

  translate([-3.6*xoff, -0.6*yoff, 0.5])
    rotate([0,0,180])
    joystick();
}
