/// @description 

if (spawn_room == -1) { 
    exit;
}

room_scale = 1;

with (obj_player) {
    x = spawn_x;
    y = spawn_y;
    facing = spawn_player_facing;

    // Now the 'facing' variable is already initialized in the Create event
    switch (facing) {   
        case dir.left:   y_frame = 9;  break;
        case dir.right:  y_frame = 11; break;
        case dir.up:     y_frame = 8;  break;
        case dir.down:   y_frame = 10; break;
        case -1:         x_frame = 0;  break;
    }   
}