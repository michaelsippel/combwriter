include <keycap_base.scad>
include <mx_switch.scad>

height_map_x = [ 12.65 , 9.2 , 4.1, 2.3, 6.9, 10.36, 12.65 ];
height_map_y = [ 1.15, 0.0, 3.6 ];

angle_map_x = [ 10, 10, 8, 0, -15, -10, -10 ];
angle_map_y = [ -10, 4, 15 ];

scale_map_x = [ 2.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 ];

thumb_height_map = [ 24, 20, 16.5, 15, 16 ];
thumb_angle_map = [ 5, 5, 3, 0, -15 ];

xoff = 17.9;
yoff = 19.3;

text_left = [
	["", "X…Ξ", "V_√", "L\[Λ", "C]χ", "W^Ω", ""],
	["", "U\\⊂", "I/∫", "A{∀", "E}∃", "O*∈", ""],
	["", "Ü#∪", "Ö$∩", "Ä|", "P~Π", "Z`ℤ", ""],
	["", "", "", "", "", ""],
];
text_right = [
	["", "K!×", "H<Ψ", "G>Γ", "F=Φ", "ẞ"],
	[".'ϑ", "S?Σ", "N(ℕ", "R)ℝ", "T-∂", "D:Δ", ""],
	["", "B+β", "M%μ", ",\"ϱ", "Y@∇", "J;θ", ""],
	["", "", "", "", "", ""],
];

function gtl(s,x,y) = [ if(s == 1) text_left[1-y][x+3] ];
function gtr(s,x,y) = [ if(s == -1) text_right[1-y][3-x] ];
function get_text(s, x, y) = concat(gtl(s,x,y), gtr(s,x,y));

function switch_positions_thumb1(xoff, yoff, s) = [
  for(x = [0:2])
    [[x, -x], [s*xoff*x, -yoff*(x - 0.5*x), 0]]
];
function switch_positions_thumb2(xoff, yoff, s) = [
  for(x = [3:4])
    [[x, -x], [s*xoff*x, -4-yoff*(x - 0.5*x), 0]]
];
function switch_positions_thumb(xoff, yoff, s) = concat(switch_positions_thumb1(xoff, yoff, s), switch_positions_thumb2(xoff, yoff, s));
function switch_positions_main(xoff, yoff, s) = [
  for(x = [-3:3])
    for(y = [-1:1])
      if(x < 3 || y >= 0)
	[[x,y], [s*xoff * x - s*scale_map_x[x+3], yoff*(2+y - 0.5*abs(x)), 0]]
];

joystick_position = [ 3*xoff, -0.5*yoff, 0 ];

function switch_positions(xoff, yoff, s) = concat(switch_positions_main(xoff, yoff, s), switch_positions_thumb(xoff,yoff, s));

module main_cluster( proto=false, s=1, xoff=20, yoff=30 ) {
  for(pos = switch_positions_main(xoff, yoff, s) ) {
    let( x = pos[0][0], y = pos[0][1] )
      if( x == 0 && y == 1) {
	// special treatment for top key in center column
	translate([0, 3*yoff, 0])
	  key( 20, 0, 18.4, 0.0, proto, get_text(s, x, y) );
      } else {
	translate(pos[1])
	  key(angle_map_y[y+1],
	      angle_map_x[s*x+3],
	      9.2 + height_map_x[x+3] + height_map_y[y+1],
	      scale_map_x[x+3],
	      proto,
	      get_text(s, x, y));
      }
  }
}

module main_cluster_text(s=1, xoff=20, yoff=30) {
  for(pos = switch_positions_main(xoff, yoff, s) ) {
    let( x = pos[0][0], y = pos[0][1] )
      if( x == 0 && y == 1) {
	// special treatment for top key in center column
	translate([0, 3*yoff, 0])
	  text_cap( 20, 0, 18.4, get_text(s, x, y) );
      } else {
	translate(pos[1])
	  text_cap(angle_map_y[y+1],
	      angle_map_x[s*x+3],
	      9.2 + height_map_x[x+3] + height_map_y[y+1],
		   get_text(s, x, y));
      }
  }  
}

module thumb_cluster( proto=false, s=1, xoff=20, yoff=25 ) {
  for(pos = switch_positions_thumb(xoff, yoff, s))
    let( x = pos[0][0], y = pos[0][1] )
      translate(pos[1])
      key(15, s*thumb_angle_map[x], thumb_height_map[x], 0.0, proto, get_text(3, x));
}

module plate(xoff, yoff, s=1, height=2, d=30) {
  translate([0,0,-height])
    {
  for(pos = switch_positions(xoff, yoff, s) )
    {
      translate(pos[1])
	{
	cylinder(h=height, d=d, $fn=6);

	translate([-s*scale_map_x[pos[0][0]+3], 0,0])
	  cylinder(h=height, d=d, $fn=6);
	}
    }

  translate([s*joystick_position[0], joystick_position[1], joystick_position[2]])
  {
    cylinder(h=height, d=d, $fn=6);

    translate([s*xoff, -yoff*0.5, 0])
      cylinder(h=height, d=d, $fn=6);
  }
    }
}

module switches(xoff, yoff, s) {
  for(pos = switch_positions(xoff, yoff, s))
    translate(pos[1])
      color([1,0,0])
      translate([0,0,1])
      mx_switch();
}

module thumb_joystick() {
  union() {
    cylinder(d=18, h=2.5, $fn=32);

    translate([0,0,2.5])
      scale([1, 1,0.5])
      sphere(d=18, $fn=32);

    translate([0,0,8])
      scale([1, 1, 0.3])
      sphere(d=12, $fn=32);
  }
}
