//this clears the board and creates a new game of minesweeper
var room_in_tiles_w = argument[0];
var room_in_tiles_h = argument[1];

board_w = room_in_tiles_w; //as int or whole number
board_h = room_in_tiles_h - 1;//as int or whole number

//also resize the room
var new_room_w = room_in_tiles_w * tile_size;
var new_room_h = room_in_tiles_h * tile_size;



room_set_width(room_to_swap_id,new_room_w);
room_set_height(room_to_swap_id,new_room_h);



//board in correct size
ds_grid_resize(undertile_grid,board_w,board_h);
ds_grid_resize(overtile_grid,board_w,board_h);
//clear" the board
for(var tx = 0; tx < board_w; tx += 1;)
{
    for(var ty = 0; ty < board_h; ty += 1;)
    {
        ds_grid_set(undertile_grid,tx,ty,UNDERTILE_TYPE.BLANK); 
        ds_grid_set(overtile_grid,tx,ty,OVERTILE_TYPE.BLANK); 
    }
}

//get difficulty/total bombs
var total_tiles_on_board = board_w * board_h;
var total_bombs = floor((total_tiles_on_board)/0) + 1;//was 6
var bombs_left_to_place = total_bombs;
var this_tiles_bomb_placement_chance = total_bombs/total_tiles_on_board;

//randomize where the bombs are at
while(bombs_left_to_place > 0)
{
    for(var tx = 0; tx < board_w; tx += 1;)
    {
        for(var ty = 0; ty < board_h; ty += 1;)
        {
            if (ds_grid_get(undertile_grid,tx,ty) != UNDERTILE_TYPE.BOMB)
            {
                if (random_range(0,1) <= this_tiles_bomb_placement_chance)
                {
                    //place bomb on this tile
                    ds_grid_set(undertile_grid,tx,ty,UNDERTILE_TYPE.BOMB);
                    bombs_left_to_place -= 1;
                    
                    if(bombs_left_to_place == 0)
                    {
                        break;
                    }
                }
            }
        }
        
         if(bombs_left_to_place == 0)
        {
            break;
        }
    }
}




//now go through with bombs in place and set what numbers go where
for(var tx = 0; tx < board_w; tx += 1;)
{
    for(var ty = 0; ty < board_h; ty += 1;)
    {
        var this_undertile_type = ds_grid_get(undertile_grid,tx,ty);
        
        //if its not a bomb...give it a number based on #of bombs surrounding it
        if (this_undertile_type != UNDERTILE_TYPE.BOMB)
        {
            var total_surrounding_bombs = 0;
            
            for(var sx = -1; sx <= 1; sx += 1;)
            {
                for(var sy = -1; sy <= 1; sy += 1;)
                {
                    if (sx != 0 or sy != 0)
                    {
                        var fsx = tx + sx;
                        var fsy = ty + sy;
                        
                        if (fsx >= 0 and fsx < board_w and fsy >= 0 and fsy < board_h)
                        {
                            var this_surrounding_undertile_type = ds_grid_get(undertile_grid,fsx,fsy);
                            
                            if (this_surrounding_undertile_type == UNDERTILE_TYPE.BOMB)
                            {
                                total_surrounding_bombs += 1;
                            }
                        }
                    }
                }
            }
            
            //finally set the new number type
            ds_grid_set(undertile_grid,tx,ty,total_surrounding_bombs);           
        }      
    }
}






//at very end...swap rooms
room_goto(room_play_2);
//room_to_swap_id = room;






