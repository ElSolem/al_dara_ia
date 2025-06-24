package main

import "core:fmt"
import "core:time"
import "vendor:sdl2"
import sdl2image "vendor:sdl2/image"
import "core:math"
import rand "core:math/rand"
import noise "core:math/noise"


// <- ARRAYS FOR VARIOUS TILE OBJECTS ->
dirt_objects := [7]Animation{bush, birch_sign, bush, cave_stone4, mini_tree, mini_tree, pot}
gravel_objects := [7]Animation{cave_stone1, oak_sign, cave_stone2, cave_stone4, cave_stone3, cave_stone5, pot}
water_objects := [2]Animation{water_rock, water_rocks}

berrytrees := [66]Animation{
    berrytree_AGUAVBERRY, berrytree_APICOTBERRY, berrytree_ASPEARBERRY, berrytree_BABIRIBERRY, berrytree_BELUEBERRY, berrytree_BLUKBERRY, berrytree_CHARTIBERRY, berrytree_CHERIBERRY, berrytree_CHESTOBERRY, berrytree_CHILANBERRY, berrytree_CHOPLEBERRY,
    berrytree_COBABERRY, berrytree_COLBURBERRY, berrytree_CORNNBERRY, berrytree_CUSTAPBERRY, berrytree_DURINBERRY, berrytree_ENIGMABERRY, berrytree_FIGYBERRY, berrytree_GANLONBERRY, berrytree_GREPABERRY, berrytree_HABANBERRY, berrytree_HONDEWBERRY,
    berrytree_IAPAPABERRY, berrytree_JABOCABERRY, berrytree_KASIBBERRY, berrytree_KEBIABERRY, berrytree_KEEBERRY, berrytree_KELPSYBERRY, berrytree_LANSATBERRY, berrytree_LEPPABERRY, berrytree_LIECHIBERRY, berrytree_LUMBERRY, berrytree_MAGOBERRY,
    berrytree_MARANGABERRY, berrytree_MICLEBERRY, berrytree_NANABBERRY, berrytree_NOMELBERRY, berrytree_OCCABERRY, berrytree_ORANBERRY, berrytree_PAMTREBERRY, berrytree_PASSHOBERRY, berrytree_PAYAPABERRY, berrytree_PECHABERRY, berrytree_PERSIMBERRY,
    berrytree_PETAYABERRY, berrytree_PINAPBERRY, berrytree_POMEGBERRY, berrytree_QUALOTBERRY, berrytree_RABUTABERRY, berrytree_RAWSTBERRY, berrytree_RAZZBERRY, berrytree_RINDOBERRY, berrytree_ROSELIBERRY, berrytree_ROWAPBERRY, berrytree_SALACBERRY,
    berrytree_SHUCABERRY, berrytree_SITRUSBERRY, berrytree_SPELONBERRY, berrytree_STARFBERRY, berrytree_TAMATOBERRY, berrytree_TANGABERRY, berrytree_WACANBERRY, berrytree_WATMELBERRY, berrytree_WEPEARBERRY, berrytree_WIKIBERRY, berrytree_YACHEBERRY
}


// <- LOAD THE ANIMATIONS ->
berrytree_AGUAVBERRY: Animation = Animation{
    sheet          = sdl2image.Load("assets/tilesets/berries/berrytree_AGUAVBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_APICOTBERRY: Animation = Animation{
    sheet          = sdl2image.Load("assets/tilesets/berries/berrytree_APICOTBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_ASPEARBERRY: Animation = Animation{
    sheet          = sdl2image.Load("assets/tilesets/berries/berrytree_ASPEARBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_BABIRIBERRY: Animation = Animation{
    sheet          = sdl2image.Load("assets/tilesets/berries/berrytree_BABIRIBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_BELUEBERRY: Animation = Animation{
    sheet          = sdl2image.Load("assets/tilesets/berries/berrytree_BELUEBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_BLUKBERRY: Animation = Animation{
    sheet          = sdl2image.Load("assets/tilesets/berries/berrytree_BLUKBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_CHARTIBERRY: Animation = Animation{
    sheet          = sdl2image.Load("assets/tilesets/berries/berrytree_CHARTIBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_CHERIBERRY: Animation = Animation{
    sheet          = sdl2image.Load("assets/tilesets/berries/berrytree_CHERIBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_CHESTOBERRY: Animation = Animation{
    sheet          = sdl2image.Load("assets/tilesets/berries/berrytree_CHESTOBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_CHILANBERRY: Animation = Animation{
    sheet          = sdl2image.Load("assets/tilesets/berries/berrytree_CHILANBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_CHOPLEBERRY: Animation = Animation{
    sheet          = sdl2image.Load("assets/tilesets/berries/berrytree_CHOPLEBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_COBABERRY: Animation = Animation{
    sheet          = sdl2image.Load("assets/tilesets/berries/berrytree_COBABERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_COLBURBERRY: Animation = Animation{
    sheet          = sdl2image.Load("assets/tilesets/berries/berrytree_COLBURBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_CORNNBERRY: Animation = Animation{
    sheet          = sdl2image.Load("assets/tilesets/berries/berrytree_CORNNBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_CUSTAPBERRY: Animation = Animation{
    sheet          = sdl2image.Load("assets/tilesets/berries/berrytree_CUSTAPBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_DURINBERRY: Animation = Animation{
    sheet          = sdl2image.Load("assets/tilesets/berries/berrytree_DURINBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_ENIGMABERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_ENIGMABERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_FIGYBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_FIGYBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_GANLONBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_GANLONBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_GREPABERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_GREPABERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_HABANBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_HABANBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_HONDEWBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_HONDEWBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_IAPAPABERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_IAPAPABERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_JABOCABERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_JABOCABERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_KASIBBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_KASIBBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_KEBIABERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_KEBIABERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_KEEBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_KEEBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_KELPSYBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_KELPSYBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_LANSATBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_LANSATBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_LEPPABERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_LEPPABERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_LIECHIBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_LIECHIBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_LUMBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_LUMBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_MAGOBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_MAGOBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_MAGOSTBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_MAGOSTBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_MARANGABERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_MARANGABERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_MICLEBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_MICLEBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_NANABBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_NANABBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_NOMELBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_NOMELBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_OCCABERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_OCCABERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_ORANBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_ORANBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_PAMTREBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_PAMTREBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_PASSHOBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_PASSHOBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_PAYAPABERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_PAYAPABERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_PECHABERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_PECHABERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_PERSIMBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_PERSIMBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}


berrytree_PETAYABERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_PETAYABERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_PINAPBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_PINAPBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_POMEGBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_POMEGBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_QUALOTBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_QUALOTBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_RABUTABERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_RABUTABERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_RAWSTBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_RAWSTBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_RAZZBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_RAZZBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_RINDOBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_RINDOBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_ROSELIBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_ROSELIBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_ROWAPBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_ROWAPBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_SALACBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_SALACBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_SHUCABERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_SHUCABERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_SITRUSBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_SITRUSBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_SPELONBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_SPELONBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_STARFBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_STARFBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_TAMATOBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_TAMATOBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_TANGABERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_TANGABERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_WACANBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_WACANBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_WATMELBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_WATMELBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_WEPEARBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_WEPEARBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_WIKIBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_WIKIBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

berrytree_YACHEBERRY: Animation = Animation{
    sheet          = sdl2image.Load("pokeseior/assets/tilesets/berries/berrytree_YACHEBERRY.png"),
    frame_width    = 32,
    frame_height   = 64,
    total_frames   = 16, // 4 rows * 4 columns = 16 frames
    frames_per_row = 4,
}

// Environment Object Animations
flowers: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/autotiles/base_tiles/Flowers2.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 5, // 4 rows * 4 columns = 16 frames
    frames_per_row = 5
}

tree: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/tree.png"),
    frame_width    = 64,
    frame_height   = 96,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

birch_sign: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/birch_sign.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

boulder: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/boulder.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

bush: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/bush.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

cave_stone1: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/cave_stone1.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

cave_stone2: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/cave_stone2.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

cave_stone3: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/cave_stone3.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

cave_stone4: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/cave_stone4.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

cave_stone5: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/cave_stone5.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

clipboard: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/clipboard.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

fossil: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/fossil.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

gold_nest: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/gold_nest.png"),
    frame_width    = 64,
    frame_height   = 96,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

grass: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/grass.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

metal_sign: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/metal_sign.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

mini_tree: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/mini_tree.png"),
    frame_width    = 32,
    frame_height   = 96,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

oak_sign: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/oak_sign.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

plantbox: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/plantbox.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

pokedex: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/pokedex.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

pot: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/pot.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

silver_nest: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/silver_nest.png"),
    frame_width    = 64,
    frame_height   = 96,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

townmap: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/townmap.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

water_rock: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/water_rock.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

water_rocks: Animation = Animation {
    sheet          = sdl2image.Load("assets/tilesets/objects/water_rocks.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1, // 4 rows * 4 columns = 16 frames
    frames_per_row = 1
}

// Items converted to size

huh: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/000.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ABILITYURGE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ABILITYURGE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ABSORBBULB: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ABSORBBULB.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ADAMANTORB: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ADAMANTORB.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

AGUAVBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/AGUAVBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

AIRBALLOON: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/AIRBALLOON.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

AIRMAIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/AIRMAIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

AMULETCOIN: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/AMULETCOIN.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ANTIDOTE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ANTIDOTE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

APICOTBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/APICOTBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ARMORFOSSIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ARMORFOSSIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ASPEARBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ASPEARBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

AURORATICKET: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/AURORATICKET.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

AWAKENING: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/AWAKENING.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BABIRIBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BABIRIBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BALMMUSHROOM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BALMMUSHROOM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BELUEBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BELUEBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BERRYJUICE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BERRYJUICE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BICYCLE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BICYCLE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BIGMUSHROOM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BIGMUSHROOM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BIGNUGGET: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BIGNUGGET.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BIGPEARL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BIGPEARL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BIGROOT: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BIGROOT.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BINDINGBAND: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BINDINGBAND.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BLACKAPRICORN: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BLACKAPRICORN.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BLACKBELT: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BLACKBELT.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BLACKFLUTE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BLACKFLUTE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BLACKGLASSES: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BLACKGLASSES.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BLACKSLUDGE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BLACKSLUDGE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BLOOMMAIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BLOOMMAIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BLUEAPRICORN: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BLUEAPRICORN.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BLUEFLUTE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BLUEFLUTE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BLUESCARF: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BLUESCARF.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BLUESHARD: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BLUESHARD.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BLUKBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BLUKBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BRICKMAIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BRICKMAIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BRIGHTPOWDER: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BRIGHTPOWDER.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BUBBLEMAIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BUBBLEMAIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BUGGEM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BUGGEM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BURNDRIVE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BURNDRIVE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

BURNHEAL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/BURNHEAL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

CALCIUM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/CALCIUM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

CARBOS: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/CARBOS.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

CASTELIACONE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/CASTELIACONE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

CELLBATTERY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/CELLBATTERY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

CHARCOAL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/CHARCOAL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

CHARTIBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/CHARTIBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

CHERIBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/CHERIBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

CHERISHBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/CHERISHBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

CHESTOBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/CHESTOBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

CHILANBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/CHILANBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

CHILLDRIVE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/CHILLDRIVE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

CHOICEBAND: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/CHOICEBAND.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

CHOICESCARF: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/CHOICESCARF.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

CHOICESPECS: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/CHOICESPECS.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

CHOPLEBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/CHOPLEBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

CLAWFOSSIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/CLAWFOSSIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

CLEANSETAG: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/CLEANSETAG.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

CLEVERWING: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/CLEVERWING.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

COBABERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/COBABERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

COINCASE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/COINCASE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

COLBURBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/COLBURBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

COMETSHARD: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/COMETSHARD.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

CORNNBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/CORNNBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

COVERFOSSIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/COVERFOSSIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

CUSTAPBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/CUSTAPBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DAMPMULCH: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DAMPMULCH.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DAMPROCK: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DAMPROCK.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DARKGEM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DARKGEM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DAWNSTONE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DAWNSTONE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DEEPSEASCALE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DEEPSEASCALE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DEEPSEATOOTH: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DEEPSEATOOTH.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DESTINYKNOT: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DESTINYKNOT.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DEVONSCOPE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DEVONSCOPE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DIREHIT: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DIREHIT.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DIREHIT2: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DIREHIT2.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DIREHIT3: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DIREHIT3.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DIVEBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DIVEBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DNASPLICERS: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DNASPLICERS.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DNASPLICERSUSED: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DNASPLICERSUSED.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DOMEFOSSIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DOMEFOSSIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DOUSEDRIVE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DOUSEDRIVE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DOWSINGMACHINE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DOWSINGMACHINE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DRACOPLATE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DRACOPLATE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DRAGONFANG: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DRAGONFANG.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DRAGONGEM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DRAGONGEM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DRAGONSCALE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DRAGONSCALE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DREADPLATE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DREADPLATE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DUBIOUSDISC: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DUBIOUSDISC.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DURINBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DURINBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DUSKBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DUSKBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

DUSKSTONE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/DUSKSTONE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

EARTHPLATE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/EARTHPLATE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

EJECTBUTTON: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/EJECTBUTTON.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ELECTIRIZER: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ELECTIRIZER.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ELECTRICGEM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ELECTRICGEM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ELIXIR: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ELIXIR.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ENERGYPOWDER: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ENERGYPOWDER.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ENERGYROOT: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ENERGYROOT.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ENIGMABERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ENIGMABERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ESCAPEROPE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ESCAPEROPE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ETHER: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ETHER.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

EVERSTONE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/EVERSTONE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

EVIOLITE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/EVIOLITE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

EXPERTBELT: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/EXPERTBELT.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

EXPSHARE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/EXPSHARE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

FASTBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/FASTBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

FIGHTINGGEM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/FIGHTINGGEM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

FIGYBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/FIGYBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

FIREGEM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/FIREGEM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

FIRESTONE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/FIRESTONE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

FISTPLATE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/FISTPLATE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

FLAMEMAIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/FLAMEMAIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

FLAMEORB: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/FLAMEORB.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

FLAMEPLATE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/FLAMEPLATE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

FLOATSTONE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/FLOATSTONE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

FLUFFYTAIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/FLUFFYTAIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

FLYINGGEM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/FLYINGGEM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

FOCUSBAND: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/FOCUSBAND.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

FOCUSSASH: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/FOCUSSASH.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

FRESHWATER: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/FRESHWATER.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

FRIENDBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/FRIENDBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

FULLHEAL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/FULLHEAL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

FULLINCENSE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/FULLINCENSE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

FULLRESTORE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/FULLRESTORE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

GANLONBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/GANLONBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

GENIUSWING: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/GENIUSWING.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

GHOSTGEM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/GHOSTGEM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

GOODROD: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/GOODROD.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

GOOEYMULCH: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/GOOEYMULCH.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

GRACIDEA: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/GRACIDEA.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

GRASSGEM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/GRASSGEM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

GRASSMAIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/GRASSMAIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

GREATBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/GREATBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

GREENAPRICORN: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/GREENAPRICORN.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

GREENSCARF: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/GREENSCARF.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

GREENSHARD: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/GREENSHARD.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

GREPABERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/GREPABERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

GRIPCLAW: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/GRIPCLAW.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

GRISEOUSORB: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/GRISEOUSORB.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

GROUNDGEM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/GROUNDGEM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

GROWTHMULCH: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/GROWTHMULCH.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

GUARDSPEC: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/GUARDSPEC.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

HABANBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/HABANBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

HARDSTONE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/HARDSTONE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

HEALBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/HEALBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

HEALPOWDER: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/HEALPOWDER.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

HEALTHWING: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/HEALTHWING.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

HEARTMAIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/HEARTMAIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

HEARTSCALE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/HEARTSCALE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

HEATROCK: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/HEATROCK.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

HEAVYBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/HEAVYBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

HELIXFOSSIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/HELIXFOSSIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

HONDEWBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/HONDEWBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

HONEY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/HONEY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

HPUP: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/HPUP.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

HYPERPOTION: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/HYPERPOTION.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

IAPAPABERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/IAPAPABERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ICEGEM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ICEGEM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ICEHEAL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ICEHEAL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ICICLEPLATE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ICICLEPLATE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ICYROCK: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ICYROCK.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

INSECTPLATE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/INSECTPLATE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

IRON: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/IRON.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

IRONBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/IRONBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

IRONPLATE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/IRONPLATE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ITEMDROP: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ITEMDROP.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ITEMFINDER: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ITEMFINDER.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ITEMURGE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ITEMURGE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

JABOCABERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/JABOCABERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

KASIBBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/KASIBBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

KEBIABERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/KEBIABERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

KELPSYBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/KELPSYBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

KINGSROCK: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/KINGSROCK.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LAGGINGTAIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LAGGINGTAIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LANSATBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LANSATBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LAVACOOKIE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LAVACOOKIE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LAXINCENSE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LAXINCENSE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LEAFSTONE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LEAFSTONE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LEFTOVERS: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LEFTOVERS.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LEMONADE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LEMONADE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LEPPABERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LEPPABERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LEVELBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LEVELBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LIECHIBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LIECHIBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LIFEORB: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LIFEORB.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LIGHTBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LIGHTBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LIGHTCLAY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LIGHTCLAY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LOVEBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LOVEBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LUCKINCENSE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LUCKINCENSE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LUCKYEGG: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LUCKYEGG.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LUCKYPUNCH: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LUCKYPUNCH.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LUMBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LUMBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LUREBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LUREBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LUSTROUSORB: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LUSTROUSORB.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

LUXURYBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/LUXURYBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MACHOBRACE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MACHOBRACE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MAGMARIZER: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MAGMARIZER.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MAGNET: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MAGNET.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MAGOBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MAGOBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MAGOSTBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MAGOSTBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MASTERBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MASTERBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MAXELIXIR: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MAXELIXIR.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MAXETHER: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MAXETHER.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MAXPOTION: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MAXPOTION.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MAXREPEL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MAXREPEL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MAXREVIVE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MAXREVIVE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MEADOWPLATE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MEADOWPLATE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MENTALHERB: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MENTALHERB.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

METALCOAT: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/METALCOAT.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

METALPOWDER: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/METALPOWDER.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

METRONOME: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/METRONOME.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MICLEBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MICLEBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MINDPLATE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MINDPLATE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MIRACLESEED: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MIRACLESEED.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MOOMOOMILK: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MOOMOOMILK.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MOONBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MOONBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MOONSTONE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MOONSTONE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MOSAICMAIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MOSAICMAIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MUSCLEBAND: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MUSCLEBAND.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MUSCLEWING: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MUSCLEWING.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

MYSTICWATER: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/MYSTICWATER.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

NANABBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/NANABBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

NESTBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/NESTBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

NETBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/NETBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

NEVERMELTICE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/NEVERMELTICE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

NOMELBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/NOMELBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

NORMALGEM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/NORMALGEM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

NUGGET: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/NUGGET.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

OCCABERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/OCCABERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ODDINCENSE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ODDINCENSE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ODDKEYSTONE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ODDKEYSTONE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

OLDAMBER: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/OLDAMBER.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

OLDGATEAU: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/OLDGATEAU.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

OLDROD: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/OLDROD.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

OLDSEAMAP: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/OLDSEAMAP.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ORANBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ORANBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

OVALCHARM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/OVALCHARM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

OVALSTONE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/OVALSTONE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PAMTREBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PAMTREBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PARALYZEHEAL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PARALYZEHEAL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PASSHOBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PASSHOBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PAYAPABERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PAYAPABERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PEARL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PEARL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PEARLSTRING: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PEARLSTRING.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PECHABERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PECHABERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PERSIMBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PERSIMBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PETAYABERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PETAYABERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PINAPBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PINAPBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PINKAPRICORN: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PINKAPRICORN.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PINKSCARF: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PINKSCARF.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PLUMEFOSSIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PLUMEFOSSIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

POISONBARB: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/POISONBARB.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

POISONGEM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/POISONGEM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

POKEBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/POKEBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

POKEDOLL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/POKEDOLL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

POKEFLUTE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/POKEFLUTE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

POKERADAR: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/POKERADAR.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

POKETOY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/POKETOY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

POMEGBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/POMEGBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

POTION: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/POTION.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

POWERANKLET: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/POWERANKLET.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

POWERBAND: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/POWERBAND.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

POWERBELT: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/POWERBELT.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

POWERBRACER: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/POWERBRACER.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

POWERHERB: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/POWERHERB.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

POWERLENS: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/POWERLENS.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

POWERWEIGHT: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/POWERWEIGHT.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PPMAX: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PPMAX.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PPUP: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PPUP.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PREMIERBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PREMIERBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PRETTYWING: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PRETTYWING.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PRISMSCALE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PRISMSCALE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PROTECTOR: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PROTECTOR.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PROTEIN: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PROTEIN.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PSYCHICGEM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PSYCHICGEM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

PUREINCENSE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/PUREINCENSE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

QUALOTBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/QUALOTBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

QUICKBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/QUICKBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

QUICKCLAW: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/QUICKCLAW.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

QUICKPOWDER: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/QUICKPOWDER.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

RABUTABERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/RABUTABERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

RAGECANDYBAR: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/RAGECANDYBAR.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

RAREBONE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/RAREBONE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

RARECANDY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/RARECANDY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

RAWSTBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/RAWSTBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

RAZORCLAW: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/RAZORCLAW.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

RAZORFANG: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/RAZORFANG.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

RAZZBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/RAZZBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

REAPERCLOTH: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/REAPERCLOTH.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

REDAPRICORN: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/REDAPRICORN.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

REDCARD: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/REDCARD.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

REDFLUTE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/REDFLUTE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

REDSCARF: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/REDSCARF.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

REDSHARD: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/REDSHARD.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

RELICBAND: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/RELICBAND.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

RELICCOPPER: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/RELICCOPPER.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

RELICCROWN: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/RELICCROWN.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

RELICGOLD: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/RELICGOLD.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

RELICSILVER: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/RELICSILVER.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

RELICSTATUE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/RELICSTATUE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

RELICVASE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/RELICVASE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

REPEATBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/REPEATBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

REPEL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/REPEL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

RESETURGE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/RESETURGE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

RESISTWING: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/RESISTWING.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

REVEALGLASS: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/REVEALGLASS.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

REVIVALHERB: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/REVIVALHERB.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

REVIVE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/REVIVE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

RINDOBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/RINDOBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

RINGTARGET: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/RINGTARGET.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ROCKGEM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ROCKGEM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ROCKINCENSE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ROCKINCENSE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ROCKYHELMET: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ROCKYHELMET.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ROOTFOSSIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ROOTFOSSIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ROSEINCENSE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ROSEINCENSE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ROWAPBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ROWAPBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SACREDASH: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SACREDASH.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SAFARIBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SAFARIBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SALACBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SALACBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SCOPELENS: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SCOPELENS.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SEAINCENSE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SEAINCENSE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SHARPBEAK: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SHARPBEAK.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SHEDSHELL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SHEDSHELL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SHELLBELL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SHELLBELL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SHINYCHARM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SHINYCHARM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SHINYSTONE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SHINYSTONE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SHOALSALT: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SHOALSALT.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SHOALSHELL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SHOALSHELL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SHOCKDRIVE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SHOCKDRIVE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SHUCABERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SHUCABERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SILKSCARF: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SILKSCARF.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SILPHSCOPE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SILPHSCOPE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SILVERPOWDER: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SILVERPOWDER.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SITRUSBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SITRUSBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SKULLFOSSIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SKULLFOSSIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SKYPLATE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SKYPLATE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SLOWPOKETAIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SLOWPOKETAIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SMOKEBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SMOKEBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SMOOTHROCK: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SMOOTHROCK.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SNOWMAIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SNOWMAIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SODAPOP: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SODAPOP.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SOFTSAND: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SOFTSAND.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SOOTHEBELL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SOOTHEBELL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SOOTSACK: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SOOTSACK.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SOULDEW: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SOULDEW.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SPACEMAIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SPACEMAIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SPELLTAG: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SPELLTAG.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SPELONBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SPELONBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SPLASHPLATE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SPLASHPLATE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SPOOKYPLATE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SPOOKYPLATE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SPORTBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SPORTBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SPRAYDUCK: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SPRAYDUCK.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SQUIRTBOTTLE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SQUIRTBOTTLE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

STABLEMULCH: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/STABLEMULCH.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

STARDUST: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/STARDUST.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

STARFBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/STARFBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

STARPIECE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/STARPIECE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

STEELGEM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/STEELGEM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

STEELMAIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/STEELMAIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

STICK: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/STICK.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

STICKYBARB: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/STICKYBARB.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

STONEPLATE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/STONEPLATE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SUNSTONE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SUNSTONE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SUPERPOTION: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SUPERPOTION.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SUPERREPEL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SUPERREPEL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SUPERROD: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SUPERROD.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SWEETHEART: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SWEETHEART.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

SWIFTWING: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/SWIFTWING.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

TAMATOBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/TAMATOBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

TANGABERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/TANGABERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

THICKCLUB: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/THICKCLUB.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

THUNDERSTONE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/THUNDERSTONE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

TIMERBALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/TIMERBALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

TINYMUSHROOM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/TINYMUSHROOM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

TOWNMAP: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/TOWNMAP.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

TOXICORB: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/TOXICORB.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

TOXICPLATE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/TOXICPLATE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

TUNNELMAIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/TUNNELMAIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

TWISTEDSPOON: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/TWISTEDSPOON.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ULTRABALL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ULTRABALL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

UPGRADE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/UPGRADE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

WACANBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/WACANBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

WAILMERPAIL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/WAILMERPAIL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

WATERGEM: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/WATERGEM.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

WATERSTONE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/WATERSTONE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

WATMELBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/WATMELBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

WAVEINCENSE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/WAVEINCENSE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

WEPEARBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/WEPEARBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

WHITEAPRICORN: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/WHITEAPRICORN.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

WHITEFLUTE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/WHITEFLUTE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

WHITEHERB: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/WHITEHERB.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

WIDELENS: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/WIDELENS.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

WIKIBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/WIKIBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

WISEGLASSES: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/WISEGLASSES.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XACCURACY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XACCURACY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XACCURACY2: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XACCURACY2.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XACCURACY3: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XACCURACY3.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XACCURACY6: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XACCURACY6.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XATTACK: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XATTACK.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XATTACK2: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XATTACK2.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XATTACK3: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XATTACK3.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XATTACK6: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XATTACK6.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XDEFENSE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XDEFENSE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XDEFENSE2: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XDEFENSE2.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XDEFENSE3: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XDEFENSE3.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XDEFENSE6: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XDEFENSE6.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XSPATK: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XSPATK.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XSPATK2: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XSPATK2.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XSPATK3: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XSPATK3.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XSPATK6: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XSPATK6.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XSPDEF: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XSPDEF.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XSPDEF2: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XSPDEF2.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XSPDEF3: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XSPDEF3.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XSPDEF6: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XSPDEF6.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XSPEED: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XSPEED.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XSPEED2: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XSPEED2.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XSPEED3: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XSPEED3.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

XSPEED6: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/XSPEED6.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

YACHEBERRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/YACHEBERRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

YELLOWAPRICORN: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/YELLOWAPRICORN.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

YELLOWFLUTE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/YELLOWFLUTE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

YELLOWSCARF: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/YELLOWSCARF.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

YELLOWSHARD: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/YELLOWSHARD.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ZAPPLATE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ZAPPLATE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ZINC: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ZINC.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

ZOOMLENS: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/ZOOMLENS.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

back: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/back.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_BUG: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_BUG.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_DARK: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_DARK.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_DRAGON: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_DRAGON.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_ELECTRIC: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_ELECTRIC.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_FAIRY: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_FAIRY.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_FIGHTING: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_FIGHTING.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_FIRE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_FIRE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_FLYING: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_FLYING.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_GHOST: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_GHOST.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_GRASS: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_GRASS.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_GROUND: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_GROUND.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_ICE: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_ICE.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_NORMAL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_NORMAL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_POISON: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_POISON.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_PSYCHIC: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_PSYCHIC.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_ROCK: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_ROCK.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_STEEL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_STEEL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_WATER: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_WATER.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_hm_FIGHTING: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_hm_FIGHTING.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_hm_FLYING: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_hm_FLYING.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_hm_NORMAL: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_hm_NORMAL.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

machine_hm_WATER: Animation = Animation {
    sheet          = sdl2image.Load("assets/Items/machine_hm_WATER.png"),
    frame_width    = 32,
    frame_height   = 32,
    total_frames   = 1,
    frames_per_row = 1
}

