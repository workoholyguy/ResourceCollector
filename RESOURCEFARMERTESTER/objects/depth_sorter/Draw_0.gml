/// @description 

var inst_num = instance_number(par_depth);
var dg = ds_depth_grid;

// Resize Grid (only if it needs to)
if (ds_grid_height(dg) != inst_num) {
	ds_grid_resize(dg, 2, inst_num);
}

// Add instances to the grid
// Initialize yy before the with statement
var yy = 0;

// Add instances to the grid
with (par_depth) {
    // Directly use the outer yy variable, which is captured by the with statement
    dg[# 0, yy] = id;
    dg[# 1, yy] = y;
    // Increment the outer yy variable
    yy++;
}

// Make sure to reset yy to 0 before the next loop
yy = 0;

// Sort the grid in ascending order (lowest y at top)
ds_grid_sort(dg, 1, true);

// Loop through the grid and draw all the instances
repeat (inst_num) {
    var inst = dg[# 0, yy];
    with (inst) {
        // Since this will be handling par_depth children's draw event
        //  uncheck 'Visible' within all objects that are child of par_depth
        event_perform(ev_draw, 0);
    }
    
    yy += 1;
}