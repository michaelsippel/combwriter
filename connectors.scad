
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

