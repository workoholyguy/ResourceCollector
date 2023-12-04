//---------UPDATE INPUT
input_left		= keyboard_check(vk_left);
input_right		= keyboard_check(vk_right);
input_up		= keyboard_check(vk_up);
input_down		= keyboard_check(vk_down);
input_run		= keyboard_check(vk_shift);
input_walk		= keyboard_check(vk_control);

//---------ALTER SPEED
if(input_walk or input_run)	{ spd = abs((input_walk*w_spd) - (input_run*r_spd)); } 
else						{ spd = n_spd; }
	
//---------RESET MOVEMENT VARIABLES
moveX = 0; 
moveY = 0;

//---------GET INTENDED MOVEMENT
moveX = (input_right - input_left)*spd;
if(moveX == 0){ moveY = (input_down - input_up)*spd; }

//GET DIRECTION PLAYER IS FACING
if(moveX != 0){
	switch(sign(moveX)){
		case 1: facing = dir.right; break; 
		case -1: facing = dir.left; break;
	}	
} else if(moveY != 0){
	switch(sign(moveY)){
		case 1: facing = dir.down; break; 
		case -1: facing = dir.up; break;
	}	
} else {
	facing = -1;
}

//---------COLLISIONS
//Horizontal
if(moveX != 0) {
	var collisionH = instance_place(x+moveX, y, obj_collision);
	if(collisionH != noone and collisionH.collideable){
		repeat(abs(moveX)){
			if(!place_meeting(x+sign(moveX), y, obj_collision)){ x += sign(moveX); } 
			else { break; }
		}
		moveX = 0;
	}
} 

//Vertical
else if (moveY != 0){
	var collisionV = instance_place(x, y+moveY, obj_collision);
	if(collisionV != noone and collisionV.collideable){
		repeat(abs(moveY)){
			if(!place_meeting(x, y+sign(moveY), obj_collision)){ y += sign(moveY); } 
			else { break; }
		}
		moveY = 0;
	}
}

//Objects
var inst = instance_place(x,y,obj_transition);
if(inst != noone and facing == inst.playerFacingBefore){
	with(game){
		if(!doTransition){
			spawnRoom = inst.targetRoom;
			spawnX = inst.targetX;
			spawnY = inst.targetY;
			spawnPlayerFacing = inst.playerFacingAfter;
			doTransition = true;
		}
	}
}

//---------APPLY MOVEMENT
x += moveX;
y += moveY;