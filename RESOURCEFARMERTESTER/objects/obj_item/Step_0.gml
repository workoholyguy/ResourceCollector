/// @description 

if (drop_move) {
    x = lerp(x, goal_x, 0.1);
    y = lerp(y, goal_y, 0.1);
    
    if (abs(x - goal_x) < 1 and abs(y - goal_y) < 1) {
        drop_move = false;    
    }
} else {
    if (!keyboard_check(ord("E"))) exit;
    
    var px = obj_player.x;
    var py = obj_player.y;
    var r = detect_dst;    
    var d = point_in_rectangle(px, py, x - r, y - r, x + r, y + r);
    
    if (d) {
        r = pickup_dst;
        d = point_in_rectangle(px, py, x - r, y - r, x + r, y + r);
        
        if (!d) {
            x = lerp(x, px, 0.1);
            y = lerp(y, py, 0.1);
        } else {
            var in = item_num;
            var picked_up = false;
            var yy = 0; // Declare yy here, at the start of the scope
            
            with (obj_inventory) {
                var ds_inv = ds_inventory;
                
                // Use yy without redeclaration
                repeat (inv_slots) {
                    if (ds_inv[# 0, yy] == in) {
                        ds_inv[# 1, yy] += 1;
                        picked_up = true;
                        break;
                    }
                    yy += 1;    
                }
                
                // Reset yy before reuse
                yy = 0;
                if (!picked_up) {
                    repeat (inv_slots) {
                        if (ds_inv[# 0, yy] == item.none) {
                            ds_inv[# 0, yy] = in;
                            ds_inv[# 1, yy] = 1;
                            picked_up = true;
                            break;
                        }
                        yy += 1;    
                    }                        
                }
            }
            
            if (picked_up) {
                instance_destroy();
                show_debug_message("Picked up item: " + string(in));
                
                // Create or update the notification
                if (!instance_exists(obj_notification)) {
                    instance_create_layer(0, 0, "Instances", obj_notification);    
                }
                
                with (obj_notification) {
                    if (!ds_exists(ds_notifications, ds_type_grid)) {
                        ds_notifications = ds_grid_create(2, 1);    
                        var not_grid = ds_notifications;
                        not_grid[# 0, 0] = 1;
                        not_grid[# 1, 0] = inventory.ds_items_desc[# 0, in];
                    } else {
                        event_perform(ev_other, ev_user0);
                        
                        var not_grid = ds_notifications;
                        var grid_height = ds_grid_height(not_grid);
                        var name = inventory.ds_items_desc[# 0, in];
                        var in_grid = false;
                        
                        yy = 0; // Reuse 'yy' without redeclaring
                        repeat (grid_height) {
                            if (name == not_grid[# 1, yy] and not_grid[# 0, yy] > 0) {
                                not_grid[# 0, yy] += 1
                                in_grid = true;
                                break
                            } 
                            
                            yy += 1;
                        }
                        
                        if (!in_grid) {
                            ds_grid_resize(not_grid, ds_grid_width(not_grid), grid_height + 1);    
                            not_grid[# 0, grid_height] = 1;
                            not_grid[# 1, grid_height] = name;
                        }                        
                    }                    
                }
                
                instance_destroy();
                show_debug_message("Picked up item: " + string(in));
            }
        }        
    }    
}
