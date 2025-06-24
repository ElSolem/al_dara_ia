package main

import "core:slice"
import "core:fmt"
import "base:intrinsics"
import "core:math"
import "core:time"
import rl "vendor:raylib"
import rand "core:math/rand"
import noise "core:math/noise"
import ex "/examples"
import "core:mem"

// <- window size constants ->
SCREEN_WIDTH :: 1280
SCREEN_HEIGHT :: 720

PianoFrequencies: [96]f32 = {
    27.500, 29.135, 30.868, 32.703, 34.648, 36.708, 38.891, 41.203, 43.654, 46.249, 48.999, 51.913, // A0–B0
    55.000, 58.270, 61.735, 65.406, 69.296, 73.416, 77.782, 82.407, 87.307, 92.499, 97.999, 103.826, // C1–B1
    110.000, 116.541, 123.471, 130.813, 138.591, 146.832, 155.563, 164.814, 174.614, 184.997, 195.998, 207.652, // C2–B2
    220.000, 233.082, 246.942, 261.626, 277.183, 293.665, 311.127, 329.628, 349.228, 369.994, 391.995, 415.305, // C3–B3
    440.000, 466.164, 493.883, 523.251, 554.365, 587.330, 622.254, 659.255, 698.456, 739.989, 783.991, 830.609, // C4–B4
    880.000, 932.328, 987.767, 1046.502, 1108.731, 1174.659, 1244.508, 1318.510, 1396.913, 1479.978, 1567.982, 1661.219, // C5–B5
    1760.000, 1864.655, 1975.533, 2093.005, 2217.461, 2349.318, 2489.016, 2637.020, 2793.826, 2959.955, 3135.963, 3322.438, // C6–B6
    3520.000, 3729.310, 3951.066, 4186.009, 4434.922, 4698.636, 4978.032, 5274.041, 5587.652, 5919.911, 6271.927, 6644.875  // C7–C8
};


main :: proc() {
    t0 := time.now()
    if ZerothInit() {
        rl.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "HeimDalle")
        defer rl.CloseWindow()
        rl.InitAudioDevice()

        base_wave := GenerateSineWave(73.416, 44100, 10.0) // A4, 1 second
        tone_sound := rl.LoadSoundFromWave(base_wave)


        rl.SetTargetFPS(60)
        for !rl.WindowShouldClose() { if Fivedime() {
            rl.BeginDrawing()
            defer rl.EndDrawing()
            rl.ClearBackground(rl.BLACK)

            // <- Draw all procs after this point ->
            //DotTriangleSquares() // Square pattern made of pixel level triangles
            //ChaosDotGrid() //Scattered Concentric Dot Pattern
            //FractalPoints() // Combination of the above two
            //CosFractalWave() // Streaking parallax with dif patterns
            //SinFractalWave() // Same as above with better cascade
            //TanFractalWave() // Same as Cos and Sin but better cacscade and moire pattern
            //PixelCheckerBoard() // Checkerboard pixel grid
            //InfiniHatching() //Crazy hatching pattern
            //FourdimeSonicVisual() //This fully creates the fourdime sound effect visually
            //NewWave() //Cascade, need to play more
            //SidisCheckerboard(tone_sound)
            SidisMirrorBoard()
            //NewWave3D()
            }
        }
    }
    t1 := time.now()
    dt := time.diff(t0, t1)

    fmt.printf("Time taken: %.2f seconds\n", dt)
    fmt.printf("Time taken: %.3f seconds\n", f64(dt) / f64(time.Millisecond) / 1000.0)
    fmt.printf("Time taken: %.3f ms\n", f64(dt) / f64(time.Millisecond))
}

DotTriangleSquares :: proc() {
    // <- Calculate hue based on time to change color smoothly ->
    hue := (f32(rl.GetTime()) / 10) * 360.0

    // <- Calculate color from HSV values ->
    color := rl.ColorFromHSV(hue, 0.75, 0.75)

    // <- Iterate through each pixel on the screen ->
    for x in 1..=SCREEN_WIDTH {
        for y in 1..=SCREEN_HEIGHT {
            center := rl.Vector2{f32(x), f32(y)}
            // <- Check the condition and draw the pixel ->
            if (math.cos_f32(center.x)) * (math.sin_f32(center.y)) >= (math.tan_f32(9.9)) {
                rl.DrawPixelV(center, color)
            }
        }
    } 
}

ChaosDotGrid :: proc() {
    // <- Calculate hue based on time to change color smoothly ->
    hue := (f32(rl.GetTime()) / 10) * 360.0

    // <- Calculate color from HSV values ->
    color := rl.ColorFromHSV(hue, 0.75, 0.75)

    // <- Iterate through each pixel on the screen ->
    for x in 1..=SCREEN_WIDTH {
        for y in 1..=SCREEN_HEIGHT {
            center := rl.Vector2{f32(x), f32(y)}
            // <- Check the condition and draw the pixel ->
            if math.pow(math.tan_f32(center.x * center.y), 6) <= math.pow(math.tan_f32(center.x / center.y), (2/3)) * .000001||
            math.pow(math.tan_f32(center.x * center.y), 6) == math.pow(math.tan_f32(center.x / center.y), (2/3)) * .000001  {
                rl.DrawPixelV(center, color)
            }
        }
    } 
}

FractalPoints :: proc() {
    // <- Calculate hue based on time to change color smoothly ->
    hue := (f32(rl.GetTime()) / 10) * 360.0

    // <- Calculate color from HSV values ->
    color := rl.ColorFromHSV(hue, 0.75, 0.75)

    // <- Iterate through each pixel on the screen ->
    for x in 0..=SCREEN_WIDTH {
        for y in 0..=(SCREEN_HEIGHT) {
            center := rl.Vector2{f32(x), f32(y)}
            // <- Check the condition and draw the pixel ->
            if math.sin_f32((center.x * center.y) * 3.6) >= math.sin_f32(center.y / 360) * 1 { // <- Multiply by 1.x to change parallax effect :: eg. 1.1, 1.2, 1.3, 1.etc-> 
                rl.DrawPixelV(center, color)
            }
        }
    }
}

CosFractalWave :: proc() {
    // <- Calculate hue based on time to change color smoothly ->
    hue := (f32(rl.GetTime()) / 10) * 36.0

    // <- Calculate color from HSV values ->
    color := rl.ColorFromHSV(hue, 0.75, 0.75)

    // <- Iterate through each pixel on the screen ->
    for x in 0..=SCREEN_WIDTH {
        for y in 0..=(SCREEN_HEIGHT) {
            center := rl.Vector2{f32(x), f32(y)}
            // <- Check the condition and draw the pixel ->
            if BigCos(int(center.x * center.y)) <= BigCos(int(center.x / center.y)) {
                rl.DrawPixelV(center, color)
            }
        }
    }
}

TanFractalWave :: proc() {
    // <- Calculate hue based on time to change color smoothly ->
    hue := (f32(rl.GetTime()) / 10) * 36.0

    // <- Calculate color from HSV values ->
    color := rl.ColorFromHSV(hue, 0.75, 0.75)

    // <- Iterate through each pixel on the screen ->
    for x in 0..=SCREEN_WIDTH {
        for y in 0..=(SCREEN_HEIGHT) {
            center := rl.Vector2{f32(x), f32(y)}
            // <- Check the condition and draw the pixel ->
            if (BigTan(int(center.y * center.y)) / abs(BigTan(int(center.x / center.y)))) + 
            (BigTan(int(center.x / center.y)) / abs(BigTan(int(center.y / center.y)))) * 
            (abs(BigTan(int(center.x / center.y)) / BigTan(int(center.y / center.y)))) >= 0 {
                rl.DrawPixelV(center, color)
            }
        }
    }
}

SinFractalWave :: proc() {
    // <- Calculate hue based on time to change color smoothly ->
    hue := (f32(rl.GetTime()) / 10) * 36.0

    // <- Calculate color from HSV values ->
    color := rl.ColorFromHSV(hue, 0.75, 0.75)

    // <- Iterate through each pixel on the screen ->
    for x in 0..=SCREEN_WIDTH {
        for y in 0..=(SCREEN_HEIGHT) {
            center := rl.Vector2{f32(x), f32(y)}
            // <- Check the condition and draw the pixel ->
            if BigSin(int(center.x * center.y)) <= BigSin(int(center.x / center.y)) {
                rl.DrawPixelV(center, color)
            }
        }
    }
}


InfiniHatching :: proc() {
    // <- Calculate hue based on time to change color smoothly ->
    hue := (f32(rl.GetTime()) / 10) * 36.0

    // <- Calculate color from HSV values ->
    color := rl.ColorFromHSV(hue, 0.75, 0.75)

    // <- Iterate through each pixel on the screen ->
    for x in 0..=SCREEN_WIDTH {
        for y in 0..=(SCREEN_HEIGHT) {
            center := rl.Vector2{f32(x), f32(y)}
            // <- Check the condition and draw the pixel ->
            if f64(math.cos_f32(center.x * center.x * center.x) + math.sin_f32(center.y * center.y * center.y)) <= BigTan(0.0) {
                rl.DrawPixelV(center, color)
            }
        }
    }
}

PixelCheckerBoard :: proc() {
    // <- Calculate hue based on time to change color smoothly ->
    hue := (f32(rl.GetTime()) / 10) * 36.0

    // <- Calculate color from HSV values ->
    color := rl.ColorFromHSV(hue, 0.75, 0.75)

    // <- Iterate through each pixel on the screen ->
    for x in 0..=SCREEN_WIDTH {
        for y in 0..=(SCREEN_HEIGHT) {
            center := rl.Vector2{f32(x), f32(y)}
            // <- Check the condition and draw the pixel ->
            if f64(math.cos_f32(center.x) * math.sin_f32(center.y)) >= BigTan(0.0) {
                rl.DrawPixelV(center, color)
            }
        }
    }
}

FourdimeSonicVisual :: proc() {
    // <- Calculate hue based on time to change color smoothly ->
    hue := (f32(rl.GetTime()) / 10) * 36.0

    // <- Calculate color from HSV values ->
    color := rl.ColorFromHSV(hue, 0.75, 0.75)

    // <- Iterate through each pixel on the screen ->
    for x, w in 0..=SCREEN_WIDTH {
        for y, z in 0..=(SCREEN_HEIGHT) {
            center := rl.Vector2{f32(x), f32(y)}
            uv := rl.Vector2{
                (center.x / SCREEN_WIDTH) * 20.0 - 10.0,
                (center.y / SCREEN_HEIGHT) * 20.0 - 10.0,
            }

            val := abs(math.tan(uv.y * uv.y)) - math.tan(uv.x / uv.y)
            shade := clamp(val, 0.0, 1.0)
            rl.DrawPixelV(center, rl.ColorFromHSV(hue, 0.75, shade))

        }
    }
}

NewWave :: proc() {
    // <- Calculate hue based on time to change color smoothly ->
    hue := (f32(rl.GetTime()) / 10) * 36.0

    // <- Calculate color from HSV values ->
    color := rl.ColorFromHSV(hue, 0.75, 0.75)

    // <- Iterate through each pixel on the screen ->
    for x in 0..=SCREEN_WIDTH {
        for y in 0..=(SCREEN_HEIGHT) {
            center := rl.Vector2{f32(x), f32(y)}
            uv := rl.Vector2{
                (center.x / SCREEN_WIDTH) * 20.0 - 10.0,
                (center.y / SCREEN_HEIGHT) * 20.0 - 10.0,
            }

            val := (BigTan(int(center.y * center.y)) / abs(BigTan(int(center.x / center.y)))) + 
            (BigTan(int(center.x / center.y)) / abs(BigTan(int(center.y / center.y)))) * 
            (abs(BigTan(int(center.x / center.y)) / BigTan(int(center.y / center.y))))
            shade := clamp(val, 0.0, 1.0)
            rl.DrawPixelV(center, rl.ColorFromHSV(hue, f32(shade), 0.75))
        }
    }
}

SidisCheckerboard :: proc(tone_sound: rl.Sound) {
    hue := (f32(rl.GetTime()) / 10.0) * 36.0

    // Track one controlling frequency
    pitch_accumulator: f32 = 0.0
    pitch_sample_count: i32 = 0
    // <- Iterate through each pixel on the screen ->
    for x in 0..=SCREEN_WIDTH {
        for y in 0..=SCREEN_HEIGHT {
            center := rl.Vector2{f32(x), f32(y)}

            // Normalize pixel position to [0,1], then map to [-10,10]
            uv := rl.Vector2{
                (center.x / f32(SCREEN_WIDTH)) * 20.0 - 10.0,
                (center.y / f32(SCREEN_HEIGHT)) * 20.0 - 10.0,
            }

            // Calculate sine values
            sinx := math.sin_f32(uv.x + f32(rl.GetTime()))
            siny := math.sin_f32(uv.y + f32(rl.GetTime()))
            sinparty := math.sin_f32((sinx * siny) * f32(rl.GetTime()))
            sinpeace := math.sin_f32((sinx / siny) * f32(rl.GetTime()))

            // Calculate tanparty and tanpeace using pow
            tanparty := math.pow_f32(uv.x * uv.y, 6.0)
            tanpeace := math.pow_f32(uv.x / uv.y, 0.33)

            // equality check
            diff := math.log(abs(math.tan_f32(tanparty)), 0) == math.tan_f32(tanpeace)

            // Color from HSV based on which side of the condition it's on
            shade_color: rl.Color
            if diff {
                shade_color = rl.ColorFromHSV(hue, siny, sinpeace)
            } else {
                shade_color = rl.ColorFromHSV(hue, sinx, sinparty)
            }

            rl.DrawPixelV(center, shade_color)

             // Sample one in every ~5000 pixels to modulate pitch // math.log_f32(cast(f32) <- place at the front of val// ,1) <- place at end
            if (x * SCREEN_HEIGHT + y) % 1 == 0 {
                // Use tanparty as basis for pitch shift (normalize it)
                val := ((BigTan(int(center.y * center.y)) / abs(BigTan(int(center.x / center.y)))) +
                                             (BigTan(int(center.x / center.y)) / abs(BigTan(int(center.y / center.y)))) *
                                              abs(BigTan(int(center.x / center.y)) / BigTan(int(center.y / center.y))))

                pitch := 0.5 + math.mod(f32(val), f32(15.5))// Pitch between 0.5 and 2.0
                pitch_accumulator += pitch
                pitch_sample_count += 256
            }
        }
    }

    // After loop, update sound pitch based on sample
    if pitch_sample_count > 0 {
        avg_pitch := pitch_accumulator // f32(pitch_sample_count)
        rl.SetSoundPitch(tone_sound, avg_pitch)

        if !rl.IsSoundPlaying(tone_sound) {
            rl.PlaySound(tone_sound)
        }
    }
}

SidisMirrorBoard :: proc() {
    // <- Calculate hue based on time to change color smoothly ->
    hue := (f32(rl.GetTime()) / 10.0) * 36.0

    // <- Iterate through each pixel on the screen ->
    for x in 0..=SCREEN_WIDTH {
        for y in 0..=SCREEN_HEIGHT {
            center := rl.Vector2{f32(x), f32(y)}

            // Normalize pixel position to [0,1], then map to [-10,10]
            uv := rl.Vector2{
                (center.x / f32(SCREEN_WIDTH)) * 20.0 - 10.0,
                (center.y / f32(SCREEN_HEIGHT)) * 20.0 - 10.0,
            }

            // Calculate sine values
            sinx := math.sin_f32(uv.x + f32(rl.GetTime()))
            siny := math.sin_f32(uv.y + f32(rl.GetTime()))
            sinparty := math.sin_f32((sinx * siny) * f32(rl.GetTime()))
            sinpeace := math.sin_f32((sinx / siny) * f32(rl.GetTime()))

            // Calculate tanparty and tanpeace using pow
            tanparty := math.pow_f32(uv.x * uv.y, 6.0)
            tanpeace := math.pow_f32(uv.x / uv.y, 0.33)

            // Fuzzy equality check
            diff := math.log_f32(abs(math.tan_f32(tanparty)), 0) <= math.tan_f32(tanpeace)

            // Color from HSV based on which side of the condition it's on
            shade_color: rl.Color
            if diff {
                shade_color = rl.ColorFromHSV(hue, siny, sinpeace)
            } else {
                shade_color = rl.ColorFromHSV(hue, sinx, sinparty)
            }

            rl.DrawPixelV(center, shade_color)
        }
    }
}

NewWave3D :: proc() {
    // <- Calculate hue based on time to change color smoothly ->
    hue := (f32(rl.GetTime()) / 10.0) * 36.0

    // <- Iterate through each pixel on the screen ->
    for x in 0..=SCREEN_WIDTH {
        for y in 0..=SCREEN_HEIGHT {
            center := rl.Vector2{f32(x), f32(y)}

            // Normalize pixel position to [0,1], then map to [-10,10]
            uv := rl.Vector2{
                (center.x / f32(SCREEN_WIDTH)) * 20.0 - 10.0,
                (center.y / f32(SCREEN_HEIGHT)) * 20.0 - 10.0,
            }

            // Calculate sine values
            sinx := math.sin_f32(uv.x + f32(rl.GetTime()))
            siny := math.sin_f32(uv.y + f32(rl.GetTime()))
            sinparty := math.sin_f32((sinx * siny) * f32(rl.GetTime()))
            sinpeace := math.sin_f32((sinx / siny) * f32(rl.GetTime()))

            // Calculate tanparty and tanpeace using pow
            tanparty := math.pow_f32(uv.x * uv.y, 6.0)
            tanpeace := math.pow_f32(uv.x / uv.y, 0.33)

            // Fuzzy equality check
            diff := (BigTan(int(center.y * center.y)) / abs(BigTan(int(center.x / center.y)))) + 
            (BigTan(int(center.x / center.y)) / abs(BigTan(int(center.y / center.y)))) * 
            (abs(BigTan(int(center.x / center.y)) / BigTan(int(center.y / center.y)))) >= 0

            // Color from HSV based on which side of the condition it's on
            shade_color: rl.Color
            if diff {
                shade_color = rl.ColorFromHSV(hue, siny, sinpeace)
            } else {
                shade_color = rl.ColorFromHSV(hue, sinx, sinparty)
            }

            rl.DrawPixelV(center, shade_color)
        }
    }
}

GenerateSineWave :: proc(freq: f32, sample_rate: i32, duration_sec: f32) -> rl.Wave {
    samples_count := sample_rate * cast(i32)duration_sec
    total_bytes := samples_count * size_of(f32)

    // Allocate raw memory
    memory, ok := mem.alloc(int(total_bytes))
    samples_ptr := cast([^]f32)memory

    for i in 0..<samples_count {
        t := f32(i) / f32(sample_rate)
        samples_ptr[i] = math.tan(2.0 * math.PI * freq * t) * 0.5
    }

    wave := rl.Wave{
        cast(u32)samples_count,
        cast(u32)sample_rate,
        32,
        1,
        rawptr(samples_ptr),
    }

    return wave
}

