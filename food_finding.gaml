model foodfinding

global {
    int number_of_people <- 20;
    int number_of_food_items <- 50;
    
    init {
        create people number: number_of_people;
        create food number: number_of_food_items;
    }
}

species people skills: [moving] {
    float speed <- 1.0;
    rgb color <- #blue;
    
    // ADD THIS BLOCK BELOW
    aspect default {
        draw circle(2) color: color;
    }
    
    reflex wander {
        do wander;
    }
    
    reflex eat when: !empty(food at_distance 2.0) {
        ask food at_distance 2.0 {
            do die;
        }
        color <- #green;
    }
}

species food {
    rgb color <- #red;
    aspect default {
        draw circle(1) color: color;
    }
}

experiment MySimulation type: gui {
    output {
        display MyDisplay {
            species food;
            species people aspect: default;
        }
    }
}