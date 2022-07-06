
height_map_x = [ 12.65 , 9.2 , 4.1, 2.3, 6.9, 10.36, 12.65 ];
height_map_y = [ 1.15, 0.0, 3.6 ];

angle_map_x = [ 10, 10, 8, 0, -15, -10, -10 ];
angle_map_y = [ -10, 4, 15 ];

scale_map_x = [ 2.3, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 ];

thumb_height_map = [ 24, 20, 16.5, 15, 16 ];
thumb_angle_map = [ 5, 5, 3, 0, -15 ];

xoff = 17.9;
yoff = 19.3;

function switch_positions_thumb1(xoff, yoff, s) = [
  for(x = [0:2])
    [[x, -x], [s*xoff*x, -yoff*(x - 0.5*x), 0]]
];
function switch_positions_thumb2(xoff, yoff, s) = [
  for(x = [3:4])
    [[x, -x], [s*xoff*x, -6-yoff*(x - 0.5*x), 0]]
];
function switch_positions_thumb(xoff, yoff, s) = concat(switch_positions_thumb1(xoff, yoff, s), switch_positions_thumb2(xoff, yoff, s));
function switch_positions_main(xoff, yoff, s) = [
  for(x = [-3:3])
    for(y = [-1:1])
      if(x < 3 || y >= 0)
	[[x,y], [s*xoff * x - s*scale_map_x[x+3], yoff*(2+y - 0.5*abs(x)), 0]]
];

joystick_position_right = [ -3.6*xoff, -0.65*yoff, 0.5 ];

function switch_positions(xoff=xoff, yoff=xoff, s=s) = concat(switch_positions_main(xoff, yoff, s), switch_positions_thumb(xoff,yoff, s));

