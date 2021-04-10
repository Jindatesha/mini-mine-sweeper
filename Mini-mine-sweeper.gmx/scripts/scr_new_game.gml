//this clears the board and creates a new game of minesweeper
board_w = argument[0]; //as int or whole number
board_h = argument[1];//as int or whole number

//also resize the room
var new_room_w = board_w * tile_size;
var new_room_h = (board_h + 1) * tile_size;



room_set_width(room_to_swap_id,new_room_w);
room_set_height(room_to_swap_id,new_room_h);



//board in correct size
ds_grid_resize(the_undertile_grid,board_w,board_h);
ds_grid_resize(overtile_grid,board_w,board_h);
//clear" the board
for(var tx = 0; tx < board_w; tx += 1;)
{
    for(var ty = 0; ty < board_h; ty += 1;)
    {
        ds_grid_set(the_undertile_grid,tx,ty,UNDERTILE_TYPE.BLANK); 
        ds_grid_set(the_undertile_grid,tx,ty,OVERTILE_TYPE.BLANK); 
    }
}

//get difficulty/total bombs
var total_tiles_on_board = board_w * board_h;
var total_bombs = floor((total_tiles_on_board)/5) + 1;
var bombs_left_to_place = total_bombs;
var this_tiles_bomb_placement_chance = total_bombs/total_tiles_on_board;

//randomize where the bombs are at
while(bombs_left_to_place > 0)
{
    for(var tx = 0; tx < board_w; tx += 1;)
    {
        for(var ty = 0; ty < board_h; ty += 1;)
        {
            if (ds_grid_get(the_undertile_grid,tx,ty) != UNDERTILE_TYPE.BOMB)
            {
                if (random_range(0,1) <= this_tiles_bomb_placement_chance)
                {
                    //place bomb on this tile
                    ds_grid_set(the_undertile_grid,tx,ty,UNDERTILE_TYPE.BOMB);
                    bombs_left_to_place -= 1;
                }
            }
        }
    }
}




//at very end...swap rooms
room_goto(room_play_2);
//room_to_swap_id = room;






