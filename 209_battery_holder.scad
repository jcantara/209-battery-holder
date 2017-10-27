// cell dimensions, measured to 32860 cell in-hand
cell_diameter = 33;
cell_height = 70;

// configured for Keystone "209" clip:
clip_gap = 3.5; // gap between wall of holder and battery where spring clip sits, compressed size
clip_wall = 1.78; // width of printed wall onto which clip clips
clip_top_wall_to_hook = 5.4; // minimum distance between edge of clip wall and hook on clip
clip_width = 8.05;

// holder dimensions
wall_thickness = 2.0;


// transparent battery image
module battery(cell_height, cell_diameter) {
    cylinder(h=cell_height, d=cell_diameter, center=false, $fn=100);
}
%battery(cell_height, cell_diameter);


difference(){
    // positive shapes
    union(){
        // end-plates
        translate([-cell_diameter/2-wall_thickness,-clip_top_wall_to_hook,-clip_wall-clip_gap]){
            cube([cell_diameter+wall_thickness*2, cell_diameter/2+clip_top_wall_to_hook, clip_wall]);
        }
        translate([-cell_diameter/2-wall_thickness,-clip_top_wall_to_hook,cell_height+clip_gap]){
            cube([cell_diameter+wall_thickness*2, cell_diameter/2+clip_top_wall_to_hook, clip_wall]);
        }
        // side-walls
        translate([cell_diameter/2,-clip_top_wall_to_hook,-clip_gap]){
            cube([wall_thickness, cell_diameter/2+clip_top_wall_to_hook, cell_height+clip_gap*2]);
        }
        translate([-cell_diameter/2-wall_thickness,-clip_top_wall_to_hook,-clip_gap]){
            cube([wall_thickness, cell_diameter/2+clip_top_wall_to_hook, cell_height+clip_gap*2]);
        }
        // supports
        translate([-cell_diameter/2-wall_thickness,0,cell_height*4/5]){
            cube([cell_diameter+wall_thickness*2, cell_diameter/2, clip_wall]);
        }
        translate([-cell_diameter/2-wall_thickness,0,cell_height/5]){
            cube([cell_diameter+wall_thickness*2, cell_diameter/2, clip_wall]);
        }
        // base
        translate([-cell_diameter/2-wall_thickness,cell_diameter/2,-clip_wall-clip_gap]){
            cube([cell_diameter+wall_thickness*2,wall_thickness,cell_height+clip_gap*2+clip_wall*2]);
        }
        // retainer
        difference(){
            translate([-cell_diameter/2-wall_thickness,-clip_top_wall_to_hook,-clip_gap]){
                cube([cell_diameter+wall_thickness*2, clip_top_wall_to_hook, clip_gap+2]);
            }
            translate([0,0,-clip_gap]){
                battery(cell_height+2*clip_gap, cell_diameter);
            }
        }

        difference(){
            translate([-cell_diameter/2-wall_thickness,-clip_top_wall_to_hook,cell_height-2-0.001]){
                cube([cell_diameter+wall_thickness*2, clip_top_wall_to_hook, clip_gap+2]);
            }
            translate([0,0,clip_gap]){
                battery(cell_height+2*clip_gap, cell_diameter);
            }
        }
    }
    // negative shapes
    union(){
        battery(cell_height, cell_diameter);
        // clip hook hole
        translate([-clip_width/2,0,-clip_wall-clip_gap-0.5]){
            cube([clip_width, 3, cell_height+clip_gap*2+clip_wall*2+1]);
        }
    }
}