model HideAndSeek

global {
    int number_of_hiders <- 20;
    
    init {
        create hider number: number_of_hiders;
        create seeker number: 1;
    }
}

species hider {
    rgb color <- #green;
    
    reflex move {
        location <- location + {rnd(-2, 2), rnd(-2, 2)};
    }
    
    aspect default {
        draw circle(1.5) color: color;
    }
}

species seeker {
    float vision_range <- 20.0;
    
    reflex search {
        // Find the nearest hider within vision range
        hider target <- hider closest_to(self);
        
        if (target != nil and (self distance_to target) < vision_range) {
            // Move towards the hider
            location <- location + (target.location - location) / 5;
            
            // Catch the hider if close enough
            if (self distance_to target < 2.0) {
                ask target { do die; }
            }
        } else {
            // Move randomly if no one is in sight
            location <- location + {rnd(-3, 3), rnd(-3, 3)};
        }
    }
    
    aspect default {
        draw triangle(3) color: #red;
        // Draw the vision range
        draw circle(vision_range) color: rgb(255, 0, 0, 50);
    }
}

experiment MyExperiment type: gui {
    output {
        display MainDisplay {
            species hider aspect: default;
            species seeker aspect: default;
        }
    }
}