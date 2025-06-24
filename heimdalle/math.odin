package main

import "core:fmt"
import "core:time"
import "vendor:sdl2"
import sdl2image "vendor:sdl2/image"
import "core:math"
import rand "core:math/rand"
import noise "core:math/noise"
import "base:intrinsics"

// 4D Initialiazation
FourdimeInit :: proc() -> bool {
    now := f64(time.now()._nsec)
    fibprime := 2.971215073e9
    max := fibprime * now //Randomized "4D" number
    for x in 0..<max {
        for y in 0..<max {
            nx := x
            ny := y
            return ((math.log(BigTan(int(nx * nx)), 0) == math.log(BigTan(int(nx /ny)), 0)) || 
             (math.log(BigTan(int(nx * ny)), 0) == math.log(BigTan(int(nx /ny)), 0)) ||
             (math.log(BigTan(int(ny * ny)), 0) == math.log(BigTan(int(nx /ny)), 0)) || 
             (math.log(BigTan(int(nx * nx)), 0) != math.log(BigTan(int(nx /ny)), 0)) ||
             (math.log(BigTan(int(nx * ny)), 0) != math.log(BigTan(int(nx /ny)), 0)) ||
             (math.log(BigTan(int(ny * ny)), 0) != math.log(BigTan(int(nx /ny)), 0)))
        }
    }
    time1 := (fibprime * now)
    time2 := (fibprime / now)
    return ((math.log(BigTan(int(time1)), 0) == math.log(BigTan(int(time2)), 0)) ||
           (math.log(BigTan(int(time1)), 0) != math.log(BigTan(int(time2)), 0)))
}

Fivedime :: proc() -> bool {
    now := f64(time.now()._nsec)
    fibprime := 2.971215073e9
    theta := math.PI * now
    ei := complex(math.cos(theta), math.sin(theta))
    ei_mag := abs(real(ei)) + abs(imag(ei)) 

    max := int(fibprime * now * math.PI * ei_mag) //Randomized "5D" number
    for x in 0..<max {
        for y in 0..<max {
            nx := x
            ny := y
            c := ((math.log(BigTan(int(nx * nx)), 2.0) == math.log(BigTan(int(nx /ny)), 2.0)) || 
             (math.log(BigTan(int(nx * ny)), 2.0) == math.log(BigTan(int(nx /ny)), 2.0)) ||
             (math.log(BigTan(int(ny * ny)), 2.0) == math.log(BigTan(int(nx /ny)), 2.0)) || 
             (math.log(BigTan(int(nx * nx)), 2.0) != math.log(BigTan(int(nx /ny)), 2.0)) ||
             (math.log(BigTan(int(nx * ny)), 2.0) != math.log(BigTan(int(nx /ny)), 2.0)) ||
             (math.log(BigTan(int(ny * ny)), 2.0) != math.log(BigTan(int(nx /ny)), 2.0)))

            if c {
                intrinsics.atomic_add(&c, true) // track equality matches
            }
        }
    }

    time1 := fibprime * now
    time2 := fibprime / now
    return ((math.log(BigTan(int(time1)), 2.0) == math.log(BigTan(int(time2)), 2.0)) ||
           (math.log(BigTan(int(time1)), 2.0) != math.log(BigTan(int(time2)), 2.0)))
}

ZerothInit :: proc() -> bool {
    now     := f64(time.now()._nsec)
    w       := 2.0 * math.PI
    t_c     := complex(now, 0.0)
    i_unit  := complex(0.0, 1.0)

    fibprime := 2.971215073e9
    theta    := math.PI * now
    ei       := complex(math.cos_f64(theta), math.sin_f64(theta))
    ei_mag   := abs(real(ei)) + abs(imag(ei))
    max      := int(fibprime * now * math.PI * ei_mag)

    count: i32 = 0

    for x in -max..<max {
        nx := f64(x)
        wt_abs := abs(w * nx)

        // --- Expressions ---
        e1 := complex(wt_abs, wt_abs) * t_c
        e2 := complex(0.0, wt_abs * wt_abs) * t_c
        e3 := complex(-wt_abs * wt_abs, 0.0) * t_c
        e4 := complex(wt_abs, -wt_abs) * t_c

        // --- Expression 5 (complex power): abs(wt)^(i * abs(wt))
        log_val := math.log_f64(wt_abs, 2.0)
        exp_angle := wt_abs * log_val
        e5 := complex(math.cos_f64(exp_angle), math.sin_f64(exp_angle)) * t_c

        // --- Real inequality space
        y := x
        xt := f64(x) * now
        yt := f64(y) * now
        e6 := (abs(xt) + abs(yt)) <= 1.0

        // --- Phasor field
        angle := w * nx
        e7 := complex(math.cos_f64(angle), math.sin_f64(angle)) * t_c

        abs_diff := (abs(f64(x)) - abs(f64(y))) * now
        e8 := abs_diff >= 0.0

        // --- Composite logical field
        c := ((abs(real(e1)) > 0.5 || abs(imag(e1)) > 0.5) ||
              (abs(real(e2)) > 0.5 || abs(imag(e2)) > 0.5) ||
              (real(e3) < 0.0)     || (imag(e4) < 0.0)     ||
              (real(e5) > 0.0 && imag(e5) > 0.0)           ||
              e6 || (real(e7) > 0.0 && imag(e7) > 0.0)     ||
              e8)

        if c {
            count += 1 // not atomic, because you're in single-threaded loop
        }
    }

    time1 := fibprime * now
    time2 := fibprime / now
    return ((math.log(BigTan(int(time1)), 2.0) == math.log(BigTan(int(time2)), 2.0)) ||
           (math.log(BigTan(int(time1)), 2.0) != math.log(BigTan(int(time2)), 2.0)))
}

// Time Stuff
/*
t0 := time.now()
t1 := time.now()
dt := time.diff(t0, t1)
fmt.printf("Time taken: %.2f seconds\n", dt)
fmt.printf("Time taken: %.3f seconds\n", f64(dt) / f64(time.Millisecond) / 1000.0)
fmt.printf("Time taken: %.3f ms\n", f64(dt) / f64(time.Millisecond))
*/

// Math Funcs
BigTan :: proc(x: int) -> f64 {
    return math.tan(f64(x))
}

BigCos :: proc(x: int) -> f64 {
    return math.cos(f64(x))
}

BigSin :: proc(x: int) -> f64 {
    return math.sin(f64(x))
}

BigPow :: proc(x, y: int) -> f64 {
    return math.pow(f64(x), f64(y))
}

DoublePow :: proc(x: int) -> f64 {
    return math.pow(f64(x), 2)
}

TriplePow :: proc(x: int) -> f64 {
    return math.pow(f64(x), 3)
}

QuadPow :: proc(x: int) -> f64 {
    return math.pow(f64(x), 4)
}

PentaPow :: proc(x: int) -> f64 {
    return math.pow(f64(x), 5)
}

HexaPow :: proc(x: int) -> f64 {
    return math.pow(f64(x), 6)
}

SeptaPow :: proc(x: int) -> f64 {
    return math.pow(f64(x), 7)
}

OctaPow :: proc(x: int) -> f64 {
    return math.pow(f64(x), 8)
}

NonaPow :: proc(x: int) -> f64 {
    return math.pow(f64(x), 9)
}

TenPow :: proc(x: int) -> f64 {
    return f64(math.pow(f64(x), 10))
}

HalfPow :: proc(x: int) -> f64 {
    return math.pow(f64(x), 0.5)
}

ThirdPow :: proc(x: int) -> f64 {
    return math.pow(f64(x), 0.333)
}

FourthPow :: proc(x: int) -> f64 {
    return math.pow(f64(x), 0.25)
}

FifthPow :: proc(x: int) -> f64 {
    return math.pow(f64(x), 0.2)
}

SixthPow :: proc(x: int) -> f64 {
    return math.pow(f64(x), 0.166)
}

SeventhPow :: proc(x: int) -> f64 {
    return math.pow(f64(x), 0.142)
}

EighthPow :: proc(x: int) -> f64 {
    return math.pow(f64(x), 0.125)
}

NinthPow :: proc(x: int) -> f64 {
    return math.pow(f64(x), 0.111)
}

TenthPow :: proc(x: int) -> f64 {
    return math.pow(f64(x), 0.1)
}

WowPow :: proc(x: int) -> f64 {
    return math.pow(f64(x), (1/137))
}

KingPow :: proc(x: int) -> f64 {
    return math.pow(f64(x), (2/3))
}

PolyplexAlpha :: proc(x, y, a, b: f64) -> f64 {
    return math.sin(x * a + math.sin(y * b)) - (math.sin(1.5 * x) * math.cos(1.5 * y))
}

PolyplexDelta :: proc(x, y, a, b: f64) -> f64 {
    base := x * a + math.sin(y * b)
    ref  := math.sin(1.5 * x) * math.cos(1.5 * y)
    return math.sin(base - ref)
}

/* FourdimeInit :: proc() -> bool {
    now := time.now()
    x := f64((time.Second %% 9) + 1)
    y := f64((time.Nanosecond / time.Millisecond %% 9) + 1)
    return (x * y) == (x / y) || (x * y) != (x / y)
}
*/

Troolean :: enum {
    false = -1,
    nil = 0,
    true = 1,
}

troolean_not :: proc(t: Troolean) -> Troolean {
    switch t {
        case .false: return .true
        case .nil: return .nil
        case .true: return .false
    }
    return t
}

troolean_and :: proc(a, b: Troolean) -> Troolean {
    if a == .false || b == .false {
        return .false
    }
    if a == .nil || b == .nil {
        return .nil
    }
    return .true
}

troolean_or :: proc(a, b: Troolean) -> Troolean {
    if a == .true || b == .true {
        return .true
    }
    if a == .nil || b == .nil {
        return .nil
    }
    return .false
}

//Example of an Enumerated Array using Trooleans
//Future use can be within the logic of AI systems
//Works like a no hash map
TrooleanNames : [Troolean]string = {
    .false = "No",
    .nil   = "Maybe",
    .true  = "Yes",
}

get_troolean_by_name :: proc(name: string) -> Maybe(Troolean) {
    for k, v in TrooleanNames {
        if k == name {
            return v
        }
    }
    return nil // if not found
}

