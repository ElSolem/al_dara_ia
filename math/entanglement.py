import numpy as np
import matplotlib.pyplot as plt

# Parameters
t = np.linspace(0, 1, 1000)
v = 0.7  # Eccentricity-like factor
p = 5    # Semilatus rectum-like factor

# Avoid division by zero near tan's vertical asymptotes
epsilon = 1e-3
t = t[(np.abs(np.cos(2 * np.pi * t)) > epsilon) & (np.abs(np.tan(2 * np.pi * t)) < 10)]

# Compute polar-like function
r = p / (1 + v * np.cos(2 * np.pi * t))
x = r * np.cos(2 * np.pi * t)
y = r * np.tan(2 * np.pi * t)

# Plotting
plt.figure(figsize=(8, 8))
plt.plot(x, y, label=r'$\left(\frac{p}{1+v\cos(2\pi t)}\right)\cdot\tan(2\pi t)$', color='mediumvioletred')
plt.axhline(0, color='gray', linewidth=0.5)
plt.axvline(0, color='gray', linewidth=0.5)
plt.title("Modified Orbital Path with Tangent Divergence")
plt.xlabel("x")
plt.ylabel("y")
plt.axis('equal')
plt.grid(True)
plt.legend()
plt.show()
