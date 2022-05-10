include <layout.scad>


translate([-100,0,0])
{
main_cluster(false, 1);
main_cluster_text(1);
}

translate([100,0,0])
{
main_cluster(false, -1);
main_cluster_text(-1);
}
 
