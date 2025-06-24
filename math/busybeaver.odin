package main

import "core:time"
import "vendor:sdl2"
import sdl2image "vendor:sdl2/image"
import rand "core:math/rand"
import noise "core:math/noise"
import "base:intrinsics"
import "core:os"
import "core:fmt"

// Globals for BB5
bb5_states: [5][2][3]int = {
    // state A
    {{1, +1, 1}, {1, -1, 2}},
    // state B
    {{1, +1, 2}, {1, +1, 1}},
    // state C
    {{1, +1, 3}, {0, -1, 4}},
    // state D
    {{1, -1, 0}, {1, -1, 3}},
    // state E
    {{1, +1, 5}, {0, -1, 0}},
}

// Globals for BB6
bb6_states: [6][2][3]int = {
    // state 0
    {{1, 1, 1}, {1, -1, 2}},
    // state 1
    {{1, 1, 2}, {1, 1, 3}},
    // state 2
    {{1, 1, 4}, {0, -1, 0}},
    // state 3
    {{1, -1, 0}, {0, 1, 5}},
    // state 4
    {{1, -1, 5}, {0, -1, 4}},
    // state 5
    {{1, 1, 0}, {0, 1, 3}},
}

tape_size :: 1_000_000_000
tape: [tape_size]int

// Run BB5
run_bb5 :: proc(max_steps: int) -> int {
    head: int = tape_size / 2
    state: int = 0
    steps: int = 0

    for steps < max_steps {
        current := tape[head]
        action := bb5_states[state][current]
        write := action[0]
        move := action[1]
        next_state := action[2]

        tape[head] = write
        head += move
        state = next_state

        if state == 5 { // Halt state E=5
            break
        }
        steps += 1
    }
    return steps
}

// Run BB6
run_bb6 :: proc(max_steps: int) -> int {
    head: int = tape_size / 2
    state: int = 0
    steps: int = 0

    for steps < max_steps {
        current := tape[head]
        action := bb6_states[state][current]
        write := action[0]
        move := action[1]
        next_state := action[2]

        tape[head] = write
        head += move

        if next_state == 0 && move == 0 {
            break
        }
        state = next_state
        steps += 1
    }
    return steps
}

checksum :: proc() -> int {
    sum := 0
    for i in 0..<tape_size {
        sum += tape[i] * i
    }
    return sum
}

main :: proc() {

    if ZerothInit() {
    max_steps := 500_000_000

    // Clear tape
    for i in 0..<tape_size {
        tape[i] = 0
    }

    start := time.now()
    steps := run_bb5(max_steps)
    csum := checksum()
    for i in 0..<len(tape) {
        if tape[i] != 0 {
            fmt.printf("[%d] = %d", i, tape[i])
        }
    }
    end1 := time.now()
    dif := time.diff(start, end1)

    fmt.printfln("BB5 ran %d steps", steps)
    fmt.printfln("Checksum: %d", csum)
    fmt.printfln("Duration: %s", dif)

    // Clear tape again
    for i in 0..<tape_size {
        tape[i] = 0
    }

    start = time.now()
    steps = run_bb6(max_steps)
    csum = checksum()
    /* // print out the result print may crash comp -> if printed to file size <= 2.0 GB
    for i in 0..<len(tape) {
        if tape[i] {
            fmt.printfln("[%d] = %d", i, tape[i])
        }
    } */
    end2 := time.now()
    dif = time.diff(start, end2)

    fmt.printfln("BB6 ran %d steps", steps)
    fmt.printfln("Checksum: %d", csum)
    fmt.printfln("Duration: %s", dif)
    }
}
