/// @description Insert description here
// You can write your code in this editor


// Initialize input variables to false (no input)
input_left = false;
input_right = false;
input_up = false;
input_down = false;
input_slow = false;
input_fast = false;
input_interact = false;
facing = 0; // This sets the initial facing direction to down.
// Create event of obj_player
spd = 0;  // Set a default speed
active_textbox = noone;  // Initialize to no active textbox
spr_base	= spr_base_female_5;
spr_torso	= spr_torso_female_sleeveless_white;
spr_legs	= spr_legs_female_pants_teal;
spr_hair	= spr_hair_female_ponytail_raven;
spr_feet	= spr_feet_female_boots_black;
spr_shadow	= spr_character_shadow;
// Initialize movement variables
moveX = 0;
moveY = 0;