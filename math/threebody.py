import numpy as np
import matplotlib.pyplot as plt

# Time parameter
t = np.linspace(0, 1, 1000)
theta = 2 * np.pi * t

# Eccentricities for different orbits
eccentricities = [0, 0.5, 0.9, 1.0, 1.1]  # circular, elliptical, parabolic, hyperbolic
colors = ['blue', 'green', 'orange', 'red', 'purple']
labels = ['Circle (e=0)', 'Ellipse (e=0.5)', 'Ellipse (e=0.9)', 'Parabola (e=1)', 'Hyperbola (e=1.1)']

# Semi-latus rectum
p = 1.0

# Plot setup
plt.figure(figsize=(8, 8))

for e, color, label in zip(eccentricities, colors, labels):
    r = p / (1 + e * np.cos(theta))
    x = r * np.cos(theta)
    y = r * np.sin(theta)
    plt.plot(x, y, label=label, color=color)

plt.gca().set_aspect('equal')
plt.title("2D Orbital Paths (Kepler Orbits)")
plt.xlabel("x")
plt.ylabel("y")
plt.grid(True)
plt.legend()
plt.xlim(-2, 2)
plt.ylim(-2, 2)
plt.show()
