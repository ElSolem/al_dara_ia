import math
import cmath
import time

def NthInit() -> bool:
    now = time.time()
    c = 299792458
    t = now % 1.0  # normalized time [0,1]
    k = 2 * math.pi * c
    v = t + .01 # sample normalized velocity

    # Complex particle position
    p = (t * cmath.exp(complex(0, (4/3) * math.pi * t**3))) ** 3

    total = 0
    for i in range(2, 10):
        angle = i * math.pi * t
        modulator = 1 + (v * math.cos(angle))
        harmonic = (p / modulator) * math.sin(angle) + math.cos(angle)
        total += abs(harmonic)

    return total > 0.0

if NthInit():
    for i in range(0, 1_000_000):
        for j in range(0, 1_000_000):
            print("Hello Worlds!")