import numpy as np
import matplotlib.pyplot as plt

# Time domain
t = np.linspace(-1, 1, 1000)

# Orbit parameters
r1, r2, r3 = 1, 1, 1
f1, f2, f3 = 1, 2, 3
phi1, phi2, phi3 = 0, np.pi/2, np.pi

# Individual phasors
z1 = r1 * np.exp(1j * (2 * np.pi * f1 * t + phi1))
z2 = r2 * np.exp(1j * (2 * np.pi * f2 * t + phi2))
z3 = r3 * np.exp(1j * (2 * np.pi * f3 * t + phi3))

# Combined position
z = z1 + z2 + z3

# Plot
plt.figure(figsize=(6, 6))
plt.plot(z.real, z.imag, label="Combined Orbit", color="blue")
plt.title("Three-Body Phasor Interference")
plt.xlabel("Real")
plt.ylabel("Imaginary")
plt.grid(True)
plt.axis("equal")
plt.show()
