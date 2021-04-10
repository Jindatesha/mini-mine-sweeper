//scr_reveal_undertile(tile_x,tile_y);

var tx = argument[0];
var ty = argument[1];


//set the overtile type to revealed
ds_grid_set(overtile_grid,tx,ty,OVERTILE_TYPE.REVEALED);

var this_undertile_type = ds_grid_get(undertile_grid,tx,ty);

//if bomb...lose game
if (this_undertile_type == UNDERTILE_TYPE.BOMB)
{
    //can clear to_check_blanks_grid , instead optimize by re-using a cached grid
}
else
{
    //else if blank...reveal all connected blank undertiles
    if (this_undertile_type == UNDERTILE_TYPE.BLANK)
    {
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
                        
                        //make sure this OVERtile isnt already revealed
                        var this_surrounding_overtile_type = ds_grid_get(overtile_grid,fsx,fsy);
                        
                        if (this_surrounding_overtile_type != OVERTILE_TYPE.REVEALED)
                        {               
                            //make sure this undertile is blank
                            var this_surrounding_undertile_type = ds_grid_get(undertile_grid,fsx,fsy);
                            
                            if (this_surrounding_undertile_type == UNDERTILE_TYPE.BLANK)
                            {
                                //then reveal it!
                                ds_grid_set(overtile_grid,fsx,fsy,OVERTILE_TYPE.REVEALED); 
                                
                                //and add it to the blank grid to check ITS surroundings
                                var grid_w = ds_grid_width(to_check_blanks_grid);
                                var grid_h = ds_grid_height(to_check_blanks_grid);
                                ds_grid_resize(to_check_blanks_grid,grid_w,grid_h + 1);
                                
                                ds_grid_set(to_check_blanks_grid,0,grid_h,fsx);
                                ds_grid_set(to_check_blanks_grid,1,grid_h,fsy);
                                
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
    }
}






