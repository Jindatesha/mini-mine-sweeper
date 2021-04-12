//scr_reveal_undertile(tile_x,tile_y);

var tx = argument[0];
var ty = argument[1];

if (can_reveal_tiles == true)
{
    //set the overtile type to revealed
    ds_grid_set(overtile_grid,tx,ty,OVERTILE_TYPE.REVEALED);
    
    var this_undertile_type = ds_grid_get(undertile_grid,tx,ty);
    
    switch(this_undertile_type)
    {
        case UNDERTILE_TYPE.BOMB:
            if (is_first_tile_clicked == true)
            {
                has_triggered_bomb_on_first_tile = true;
                triggered_bomb_pos[0] = tx;
                triggered_bomb_pos[1] = ty;
                scr_new_game(board_w,board_h);
               
            }
            else
            {
                scr_end_match();
            }
            
        break;
        
        case UNDERTILE_TYPE.BLANK:
            //else if blank...reveal all connected blank undertiles
           
            //see what type is each of the cross pattern (4 tiles in t) 
            var to_check_blanks_grid = ds_grid_create(2,1);
            ds_grid_set(to_check_blanks_grid,0,0,tx);
            ds_grid_set(to_check_blanks_grid,1,0,ty);
                     
                 
            while(ds_grid_height(to_check_blanks_grid) > 0)
            {
                tx = ds_grid_get(to_check_blanks_grid,0,0);
                ty = ds_grid_get(to_check_blanks_grid,1,0);
               
                
                for(var sx = -1; sx <= 1; sx += 1;)
                {
                    for(var sy = -1; sy <= 1; sy += 1;)
                    {
                        if (sx == 0 or sy == 0)
                        {
                            var fsx = tx + sx;
                            var fsy = ty + sy;
                            
                            
                            if (fsx >= 0 and fsx < board_w and fsy >= 0 and fsy < board_h)
                            {
                                //make sure this OVERtile isnt already revealed
                                var this_surrounding_overtile_type = ds_grid_get(overtile_grid,fsx,fsy);
                                
                                if (this_surrounding_overtile_type != OVERTILE_TYPE.REVEALED and this_surrounding_overtile_type != OVERTILE_TYPE.FLAGGED)
                                {               
                                    //make sure this undertile is blank
                                    var this_surrounding_undertile_type = ds_grid_get(undertile_grid,fsx,fsy);
                                    
                                    if (this_surrounding_undertile_type != UNDERTILE_TYPE.BOMB)
                                    {
                                        //then reveal it!
                                        ds_grid_set(overtile_grid,fsx,fsy,OVERTILE_TYPE.REVEALED); 
                                        
                                        if (this_surrounding_undertile_type == UNDERTILE_TYPE.BLANK)
                                        {
                                            //and add it to the blank grid to check ITS surroundings
                                            var grid_w = ds_grid_width(to_check_blanks_grid);
                                            var grid_h = ds_grid_height(to_check_blanks_grid);
                                            ds_grid_resize(to_check_blanks_grid,grid_w,grid_h + 1);
                                            
                                            ds_grid_set(to_check_blanks_grid,0,grid_h,fsx);
                                            ds_grid_set(to_check_blanks_grid,1,grid_h,fsy);
                                        }
                                        //add this types score to the board
                                        total_score += this_surrounding_undertile_type;
                                    }
                                }
                            }
                        }
                    }
                }
                
                //remove this tile from the grid thats checking for other blanks
                //shift to make the last row obsolete (essentially cutting the first row)
                var grid_w = ds_grid_width(to_check_blanks_grid);
                var grid_h = ds_grid_height(to_check_blanks_grid);
                ds_grid_set_grid_region(to_check_blanks_grid,to_check_blanks_grid,0,1,1,grid_h,0,0);
                
                //resize to remove the now obsolete last row
                ds_grid_resize(to_check_blanks_grid,grid_w,grid_h - 1);
            }
            
            //clear grid
            ds_grid_destroy(to_check_blanks_grid);
            
        break;
        
        default:
            //add to our scoreboard
            total_score += this_undertile_type;
        break;
        
    }
    
    
    
    //now check to see if we have revealed all of the tiles
    scr_check_if_game_over();
}
    
is_first_tile_clicked = false;


if (has_triggered_bomb_on_first_tile == false)
{
    //play sound effect
    var snd = snd_tile_click;
    audio_play_sound(snd,0,false);
}




