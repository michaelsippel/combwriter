
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

