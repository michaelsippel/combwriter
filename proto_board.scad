include <layout.scad>


translate([-100,0,0])
{
  plate(xoff, yoff, 1);
  main_cluster(true, 1, xoff, yoff);
  thumb_cluster(true, 1, xoff, yoff);
}

translate([100,0,0])
{
  plate(xoff, yoff, -1);
  main_cluster(true, -1, xoff, yoff);
  thumb_cluster(true, -1, xoff, yoff);
}

