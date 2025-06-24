import math
import os
import cmath
import time

start_time = time.time()
# --- ZerothInit Logic ---
def ZerothInit(x: float) -> bool:
    now = os.times()[4]  # user + system time (floating-point seconds)
    w = 2.0 * math.pi
    t_c = complex(now, 0.0)

    fibprime = 2.971215073e9
    theta = math.pi * now
    ei = complex(math.cos(theta), math.sin(theta))
    ei_mag = abs(ei.real) + abs(ei.imag)
    max_val = int(fibprime * now * math.pi * ei_mag)

    count = 0

    for x_ in range(-1000, 1000):  # Use reduced range to avoid lockup
        nx = float(x_)
        wt_abs = abs(w * nx)

        # Complex expressions
        e1 = complex(wt_abs, wt_abs) * t_c
        e2 = complex(0.0, wt_abs ** 2) * t_c
        e3 = complex(-wt_abs ** 2, 0.0) * t_c
        e4 = complex(wt_abs, -wt_abs) * t_c

        log_val = math.log(wt_abs, 2) if wt_abs > 0 else 0.0
        exp_angle = wt_abs * log_val
        e5 = complex(math.cos(exp_angle), math.sin(exp_angle)) * t_c

        y = x_
        xt = float(x_) * now
        yt = float(y) * now
        e6 = (abs(xt) + abs(yt)) <= 1.0

        angle = w * nx
        e7 = complex(math.cos(angle), math.sin(angle)) * t_c

        abs_diff = (abs(float(x_)) - abs(float(y))) * now
        e8 = abs_diff >= 0.0

        c = ((abs(e1.real) > 0.5 or abs(e1.imag) > 0.5) or
             (abs(e2.real) > 0.5 or abs(e2.imag) > 0.5) or
             (e3.real < 0.0) or (e4.imag < 0.0) or
             (e5.real > 0.0 and e5.imag > 0.0) or
             e6 or (e7.real > 0.0 and e7.imag > 0.0) or
             e8)

        if c:
            count += 1

        epsilon = 1e-6
        time1 = fibprime * now
        time2 = fibprime / now

        tan1 = math.tan(time1)
        tan2 = math.tan(time2)

        # avoid domain explosions and infinities
        if abs(tan1) > 1e6 or abs(tan2) > 1e6:
            return False

        l1 = math.log(abs(tan1) + epsilon, 2.0)
        l2 = math.log(abs(tan2) + epsilon, 2.0)

        return (l1 == l2 or l1 != l2)  


# --- Busy Beaver Definition ---
bb4 = {
    ('A', 0): (1, +1, 'B'),
    ('A', 1): (1, -1, 'C'),
    ('B', 0): (1, +1, 'C'),
    ('B', 1): (1, +1, 'B'),
    ('C', 0): (1, +1, 'D'),
    ('C', 1): (0, -1, 'E'),
    ('D', 0): (1, -1, 'A'),
    ('D', 1): (1, -1, 'D'),
    ('E', 0): (1, +1, 'H'),
    ('E', 1): (0, -1, 'A'),
}

bb5 = {
    ('A', 0): (1, +1, 'B'),
    ('A', 1): (1, -1, 'C'),
    ('B', 0): (1, +1, 'C'),
    ('B', 1): (1, +1, 'B'),
    ('C', 0): (1, +1, 'D'),
    ('C', 1): (0, -1, 'E'),
    ('D', 0): (1, -1, 'A'),
    ('D', 1): (1, -1, 'D'),
    ('E', 0): (1, +1, 'H'),
    ('E', 1): (0, -1, 'A'),
}

bb6 = {
    (0, 0): (1, 1, 1),
    (0, 1): (2, 1, 0),
    (1, 0): (2, 0, -1),
    (1, 1): (3, 1, 1),
    (2, 0): (4, 1, -1),
    (2, 1): (0, 0, 1),
    (3, 0): (5, 1, -1),
    (3, 1): (1, 0, 1),
    (4, 0): (3, 1, -1),
    (4, 1): (5, 1, 1),
    (5, 0): (5, 1, 1),
    (5, 1): (0, 1, 0)  # Halting state when next state = 0 and direction = 0
}



# --- Busy Beaver Runner ---
def run_busy_beaver(machine, max_steps=1000):
    tape = {}
    head = 0
    state = 'A'
    steps = 0

    while state != 'H' and steps < max_steps:
        current = tape.get(head, 0)
        action = machine.get((state, current))
        if action is None:
            break
        write, move, next_state = action
        tape[head] = write
        head += move
        state = next_state
        steps += 1

    return steps, tape

# --- Evaluate Tape via ZerothInit ---
def evaluate_tape_with_zeroth(tape):
    values = [v for _, v in sorted(tape.items())]
    checksum = sum(v * i for i, v in enumerate(values))
    return ZerothInit(checksum)

# --- Run Everything ---
if __name__ == "__main__":
    print("Running Busy Beaver 5 through Zeroth Field...\n")
    steps, tape = run_busy_beaver(bb5, max_steps=50_000_000)
    approved = evaluate_tape_with_zeroth(tape)
    checksum = sum(v * i for i, v in enumerate(tape.values()))

    print("---- Execution Report ----")
    print("Total Steps:", steps)
    print("Tape Length:", len(tape))
    print("Tape Contents:")
    for k in sorted(tape):
        print(f"  Position {k}: {tape[k]}")
    print("Checksum:", checksum)
    print("Zeroth Verdict:", "Resonant (Accepted)" if approved else "Non-Resonant (Rejected)")
    print("Execution Time:", time.time() - start_time, "seconds")