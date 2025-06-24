package main

import "core:fmt"
import "core:time"
import "vendor:sdl2"
import sdl2image "vendor:sdl2/image"
import "core:math"
import rand "core:math/rand"
import noise "core:math/noise"

tileset_array := [7][9]^Surface{forest_tiles, grassland_tiles, beach_tiles, desert_tiles, cave_tiles, mountain_tiles, tundra_tiles}

forest_tiles : [9]^Surface = {
    0 = nil,
    1 = sdl2image.Load("assets/tilesets/forest/grass_ring.png"),
    2 = sdl2image.Load("assets/tilesets/forest/grass_spot.png"),
    3 = sdl2image.Load("assets/tilesets/forest/dirt_ring.png"),
    4 = sdl2image.Load("assets/tilesets/forest/dirt_spot.png"),
    5 = sdl2image.Load("assets/tilesets/forest/water_ring.png"),
    6 = sdl2image.Load("assets/tilesets/forest/water_spot.png"), 
    7 = sdl2image.Load("assets/tilesets/forest/gravel_ring.png"),
    8 = sdl2image.Load("assets/tilesets/forest/gravel_spot.png"),
}

grassland_tiles : [9]^Surface = {
    0 = nil,
    1 = sdl2image.Load("assets/tilesets/grassland/grass_ring.png"),
    2 = sdl2image.Load("assets/tilesets/grassland/grass_spot.png"),
    3 = sdl2image.Load("assets/tilesets/grassland/dirt_ring.png"),
    4 = sdl2image.Load("assets/tilesets/grassland/dirt_spot.png"),
    5 = sdl2image.Load("assets/tilesets/grassland/water_ring.png"),
    6 = sdl2image.Load("assets/tilesets/grassland/water_spot.png"), 
    7 = sdl2image.Load("assets/tilesets/grassland/sand_ring.png"),
    8 = sdl2image.Load("assets/tilesets/grassland/sand_spot.png"), 
}

beach_tiles : [9]^Surface = {
    0 = nil,
    1 = sdl2image.Load("assets/tilesets/beach/deepwater_ring.png"),
    2 = sdl2image.Load("assets/tilesets/beach/deepwater_spot.png"),
    3 = sdl2image.Load("assets/tilesets/beach/mud_ring.png"),
    4 = sdl2image.Load("assets/tilesets/beach/mud_spot.png"),
    5 = sdl2image.Load("assets/tilesets/beach/sand_ring.png"),
    6 = sdl2image.Load("assets/tilesets/beach/sand_spot.png"), 
    7 = sdl2image.Load("assets/tilesets/beach/redsand_ring.png"),
    8 = sdl2image.Load("assets/tilesets/beach/redsand_spot.png"), 
}

desert_tiles : [9]^Surface = {
    0 = nil,
    1 = sdl2image.Load("assets/tilesets/desert/mud_ring.png"),
    2 = sdl2image.Load("assets/tilesets/desert/mud_spot.png"),
    3 = sdl2image.Load("assets/tilesets/desert/redsand_ring.png"),
    4 = sdl2image.Load("assets/tilesets/desert/redsand_spot.png"),
    5 = sdl2image.Load("assets/tilesets/desert/sand_ring.png"),
    6 = sdl2image.Load("assets/tilesets/desert/sand_spot.png"), 
    7 = sdl2image.Load("assets/tilesets/desert/water_ring.png"),
    8 = sdl2image.Load("assets/tilesets/desert/water_spot.png"), 
}

cave_tiles : [9]^Surface = {
    0 = nil,
    1 = sdl2image.Load("assets/tilesets/cave/browncave_ring.png"),
    2 = sdl2image.Load("assets/tilesets/cave/browncave_spot.png"),
    3 = sdl2image.Load("assets/tilesets/cave/brownsand_ring.png"),
    4 = sdl2image.Load("assets/tilesets/cave/brownsand_spot.png"),
    5 = sdl2image.Load("assets/tilesets/cave/deepwater_ring.png"),
    6 = sdl2image.Load("assets/tilesets/cave/deepwater_spot.png"), 
    7 = sdl2image.Load("assets/tilesets/cave/mossstone_ring.png"),
    8 = sdl2image.Load("assets/tilesets/cave/mossstone_spot.png"), 
}

mountain_tiles : [9]^Surface = {
    0 = nil,
    1 = sdl2image.Load("assets/tilesets/mountain/gravel_ring.png"),
    2 = sdl2image.Load("assets/tilesets/mountain/gravel_spot.png"),
    3 = sdl2image.Load("assets/tilesets/mountain/graycave_ring.png"),
    4 = sdl2image.Load("assets/tilesets/mountain/graycave_spot.png"),
    5 = sdl2image.Load("assets/tilesets/mountain/snowstone_ring.png"),
    6 = sdl2image.Load("assets/tilesets/mountain/snowstone_spot.png"), 
    7 = sdl2image.Load("assets/tilesets/mountain/water_ring.png"),
    8 = sdl2image.Load("assets/tilesets/mountain/water_spot.png"), 
}

tundra_tiles : [9]^Surface = {
    0 = nil,
    1 = sdl2image.Load("assets/tilesets/tundra/deepwater_ring.png"),
    2 = sdl2image.Load("assets/tilesets/tundra/deepwater_spot.png"),
    3 = sdl2image.Load("assets/tilesets/tundra/snowgrass_ring.png"),
    4 = sdl2image.Load("assets/tilesets/tundra/snowgrass_spot.png"),
    5 = sdl2image.Load("assets/tilesets/tundra/snowstone_ring.png"),
    6 = sdl2image.Load("assets/tilesets/tundra/snowstone_spot.png"), 
    7 = sdl2image.Load("assets/tilesets/tundra/tundra_ring.png"),
    8 = sdl2image.Load("assets/tilesets/tundra/tundra_spot.png"), 
}

// Helper to ensure all tile assets are loaded
check_and_load_all_tiles :: proc() {
    for a in tileset_array {
        for i in 1..<len(a) {
            if a[i] == nil { fmt.printf("ERROR: Failed to load %p %d: %s\n", a[i], i, sdl2.GetError()) }
        }
    }
    fmt.println("All tilesets loaded (or errors reported).")
}