//scr_check_if_game_over(); sets if we have revealed all of the tiles

var over_grid_w = ds_grid_width(overtile_grid);
var over_grid_h = ds_grid_height(overtile_grid);
if (!ds_grid_value_exists(overtile_grid,0,0,over_grid_w - 1, over_grid_h - 1, OVERTILE_TYPE.BLANK))
{
    scr_end_match();
}




