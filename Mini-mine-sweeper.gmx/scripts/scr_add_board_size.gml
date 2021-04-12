//scr_add_board_size(new_board_w,new_board_h) //adds a new playable board in tiles dimension
var new_board_w = argument[0];
var new_board_h = argument[1];

//add a slot for the new board
var grid_w = ds_grid_width(board_sizes_grid);
var grid_h = ds_grid_height(board_sizes_grid);
ds_grid_resize(board_sizes_grid,grid_w,grid_h + 1);

ds_grid_set(board_sizes_grid,0,grid_h,new_board_w);
ds_grid_set(board_sizes_grid,1,grid_h,new_board_h);





