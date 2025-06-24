import numpy as np
import matplotlib.pyplot as plt

# Generate r values for multiple rotations
r = np.linspace(0, 4, 1000)  # 4 full rotations

# Compute complex values using Euler's formula
z = np.cos(2 * np.pi * r) + 1j * np.sin(2 * np.pi * r)

# Extract real and imaginary parts
x = np.real(z)
y = np.imag(z)

# Use r to determine the color (as a colormap index)
colors = plt.cm.hsv(r / max(r))

# Create the plot
fig, ax = plt.subplots(figsize=(6, 6))
ax.set_aspect('equal')
ax.set_title("Plot of cos(2πr) + i·sin(2πr) with Color by Rotation")

# Scatter plot with color representing progression
ax.scatter(x, y, c=colors, s=5)

# Axes settings
ax.axhline(0, color='gray', lw=0.5)
ax.axvline(0, color='gray', lw=0.5)
ax.set_xlabel("Real")
ax.set_ylabel("Imaginary")

plt.grid(True)
plt.tight_layout()
plt.show()
