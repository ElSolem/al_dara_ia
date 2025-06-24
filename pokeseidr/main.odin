package main

import "core:fmt"
import "core:time"
import "vendor:sdl2"
import sdl2image "vendor:sdl2/image"
import "core:math"
import rand "core:math/rand"
import noise "core:math/noise"


WINDOW_WIDTH  :: 1280
WINDOW_HEIGHT :: 720
TILE_SIZE :: 32
MAP_WIDTH_TILES :: WINDOW_WIDTH / TILE_SIZE
MAP_HEIGHT_TILES :: WINDOW_HEIGHT / TILE_SIZE

Tile :: struct {
    image : ^Surface,
    object : Animation
}

Tilemap :: [MAP_HEIGHT_TILES][MAP_WIDTH_TILES]Tile

Surface :: sdl2.Surface
Rect :: sdl2.Rect

Animation :: struct {
    sheet:             ^Surface, // The sprite sheet image
    frame_width:       i32,
    frame_height:      i32,
    total_frames:      i32,
    frames_per_row:    i32, // How many frames horizontally in one row of the sheet
}

tilemap: Tilemap 
is_map_generated := false

// --- Global Animation State ---
current_frame_index: i32 = 0
animation_timer:     f32 = 0.0 // Accumulates time for current frame
frame_duration:      f32 = 150 // How long each frame displays 

get_frame_rect :: proc(anim_def: Animation, frame_index: i32) -> Rect {
    // Ensure frame_index is within bounds
    normalized_index := frame_index % anim_def.total_frames
    if normalized_index < 0 {
        normalized_index += anim_def.total_frames
    }

    row := normalized_index / anim_def.frames_per_row
    col := normalized_index % anim_def.frames_per_row

    return sdl2.Rect{
        x = col * anim_def.frame_width,
        y = row * anim_def.frame_height,
        w = anim_def.frame_width,
        h = anim_def.frame_height,
    }
}

window := sdl2.CreateWindow(
    "PokéSeiðr",
    sdl2.WINDOWPOS_CENTERED, sdl2.WINDOWPOS_CENTERED,
    WINDOW_WIDTH, WINDOW_HEIGHT,
    sdl2.WINDOW_SHOWN
)

main :: proc() {
    t0 := time.now()
    switch {
        case !ZerothInit():
            fmt.println("Window failed fourdime init check.")
        case sdl2.Init(sdl2.INIT_VIDEO) < 0:
            fmt.printf("Failed to initialize SDL2: %s\n", sdl2.GetError())
        case sdl2image.Init(sdl2image.INIT_PNG) == nil:
            fmt.printf("Failed to initialize SDL_image: %s\n", sdl2.GetError())
        case window == nil:
            fmt.printf("Failed to create window: %s\n", sdl2.GetError())
    }

    // ---Map Generator---
    check_and_load_all_tiles()
    map_seed := (time.now()._nsec)
    noise_scale_factor := f64(.05)
    surface := sdl2.GetWindowSurface(window)
    last_frame_time := time.now()

    // --- Game Loop ---
    running := true
    event: sdl2.Event

    for running {
        current_time := time.now()
        // Convert nanoseconds difference to seconds
        delta_time := f32(current_time._nsec - last_frame_time._nsec) / 1_000_000_000.0
        last_frame_time = current_time

        for sdl2.PollEvent(&event) {
            #partial switch event.type {
                case sdl2.EventType.QUIT :
                    running = false
                case sdl2.EventType.KEYDOWN:
                    switch {
                        case event.key.keysym.scancode == sdl2.Scancode.ESCAPE:  
                            running = false
                        case event.key.keysym.scancode == sdl2.Scancode.SPACE:
                            // Regenerate map on spacebar press (for testing)
                            map_seed = time.now()._nsec
                            is_map_generated = false
                            generate_forest(map_seed, noise_scale_factor, surface, delta_time)
                    }
            }
        }
        // Draw Here
        generate_forest(map_seed, noise_scale_factor, surface, delta_time)
        sdl2.UpdateWindowSurface(window)
    }

    sdl2.DestroyWindow(window)
    sdl2.Quit()
    t1 := time.now()
    dt := time.diff(t0, t1)
    fmt.printf("Time taken: %.2f seconds\n", dt)
    fmt.printf("Time taken: %.3f seconds\n", f64(dt) / f64(time.Millisecond) / 1000.0)
    fmt.printf("Time taken: %.3f ms\n", f64(dt) / f64(time.Millisecond))
}

generate_forest :: proc(seed: i64, scale: f64, wsrf: ^Surface, delta: f32) {
    obj_chance :: .02

    if !is_map_generated {
        for y in 0..<MAP_HEIGHT_TILES {
            for x in 0..<MAP_WIDTH_TILES {
                nx := f64(x) * scale
                ny := f64(y) * scale
                coord := [2]f64{nx, ny}

                raw_noise_value := noise.noise_2d(seed, coord)
                noise_value := (raw_noise_value + 1.0) / 2.0

                tilemap[y][x].object.sheet = nil

                if ZerothInit() {
                    switch {
                        case noise_value < .30: tilemap[y][x].image = forest_tiles[2] // grass_spot
                            switch {
                                case rand.float32() < obj_chance: tilemap[y][x].object = flowers
                                case rand.float32() < obj_chance + .02: tilemap[y][x].object = rand.choice(berrytrees[:])
                                case rand.float32() < obj_chance + .2: tilemap[y][x].object = tree
                            }
                        case noise_value < .45: tilemap[y][x].image = forest_tiles[1] // grass_ring
                        
                        case noise_value < .65: tilemap[y][x].image = forest_tiles[4] // dirt_spot
                            switch {
                                case rand.float32() < obj_chance + .04: tilemap[y][x].object = rand.choice(dirt_objects[:])
                            }
                        case noise_value < .70: tilemap[y][x].image = forest_tiles[3] // dirt_ring
                    
                        case noise_value < .75: tilemap[y][x].image = forest_tiles[8] // gravel_spot
                            switch {
                                case rand.float32() < obj_chance + .02: tilemap[y][x].object = rand.choice(gravel_objects[:])
                            }
                        case noise_value < .85: tilemap[y][x].image = forest_tiles[7] // gravel_ring
            
                        case noise_value < .95: tilemap[y][x].image = forest_tiles[6] // water_spot
                            switch {
                                case rand.float32() < obj_chance + .02: tilemap[y][x].object = rand.choice(water_objects[:])
                            }
                        case: tilemap[y][x].image = forest_tiles[5] // water_ring
                        
                    }
                }
                if tilemap[y][x].image == nil {
                    tilemap[y][x].image = rand.choice(forest_tiles[:]) //no longer needed, but will keep as a backup
                    fmt.printf("WARNING: Assigned nil image at (%d,%d) with noise %f\n", x, y, noise_value)
                }
                is_map_generated = true
            }
        }
    }

    // --- Draw Base Tiles ---
    for y in 0..<MAP_HEIGHT_TILES {
        for x in 0..<MAP_WIDTH_TILES {
            tile := tilemap[y][x] 

            // Destination rectangle for the base tile
            base_rect := sdl2.Rect{
                x = i32(x * TILE_SIZE),
                y = i32(y * TILE_SIZE),
                w = TILE_SIZE,
                h = TILE_SIZE,
            }
            
            switch {
                case tile.image != nil: sdl2.BlitSurface(tile.image, nil, wsrf, &base_rect)
            }

            animation_timer += delta //delta time
            if animation_timer >= frame_duration {
                animation_timer -= frame_duration // Subtract to avoid drift
                current_frame_index = (current_frame_index + 1) % 10000
            }
            
            switch {
                case tile.object.sheet != nil:
                    current_frame_rect := get_frame_rect(tile.object, current_frame_index)

                    dest_rect := sdl2.Rect{
                        x = i32(x * TILE_SIZE) - (current_frame_rect.w - TILE_SIZE),
                        y = i32(y * TILE_SIZE) - (current_frame_rect.h - TILE_SIZE),
                        w = current_frame_rect.w,
                        h = current_frame_rect.h,
                    }
                    sdl2.BlitSurface(tile.object.sheet, &current_frame_rect, wsrf, &dest_rect)
            }
        }
    }
}