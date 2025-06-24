import numpy as np
import matplotlib.pyplot as plt
from matplotlib.collections import LineCollection

t = np.linspace(-1, 1, 2000)

# Define scaled spiraling functions
def z(n, t):
    return n * (t * np.cos(n * 2 * np.pi * t) - 1j * t * np.sin(n * 2 * np.pi * t))

z1 = z(1, t)
z2 = z(2, t)
z3 = z(3, t)

# Setup plots
fig, axs = plt.subplots(2, 2, figsize=(10, 10))

# Individual plots
axs[0, 0].plot(z1.real, z1.imag, color='dodgerblue')
axs[0, 0].set_title("z₁(t)")
axs[0, 0].grid(True)
axs[0, 0].axis("equal")

axs[0, 1].plot(z2.real, z2.imag, color='mediumseagreen')
axs[0, 1].set_title("z₂(t)")
axs[0, 1].grid(True)
axs[0, 1].axis("equal")

axs[1, 0].plot(z3.real, z3.imag, color='crimson')
axs[1, 0].set_title("z₃(t)")
axs[1, 0].grid(True)
axs[1, 0].axis("equal")

# Combined plot
axs[1, 1].plot(z1.real, z1.imag, label="z₁(t)", color='dodgerblue')
axs[1, 1].plot(z2.real, z2.imag, label="z₂(t)", color='mediumseagreen')
axs[1, 1].plot(z3.real, z3.imag, label="z₃(t)", color='crimson')
axs[1, 1].scatter(0, 0, color='black', s=30, label='Origin (z₀)')
axs[1, 1].set_title("Combined Orbits")
axs[1, 1].legend()
axs[1, 1].grid(True)
axs[1, 1].axis("equal")

plt.tight_layout()
plt.show()

t = np.linspace(-1, 1, 5000)

# Define your complex spirals
def z(n, t):
    return n * (t * np.cos(n * 2 * np.pi * t) - 1j * t * np.sin(n * 2 * np.pi * t))

# Compute complex paths
z1, z2, z3 = z(1, t), z(2, t), z(3, t)

# Helper function to color-plot spirals by t progression
def plot_spiral(ax, z, label, cmap='viridis'):
    points = np.array([z.real, z.imag]).T.reshape(-1, 1, 2)
    segments = np.concatenate([points[:-1], points[1:]], axis=1)
    lc = LineCollection(segments, cmap=cmap, norm=plt.Normalize(t.min(), t.max()))
    lc.set_array(t)
    lc.set_linewidth(2)
    line = ax.add_collection(lc)
    ax.plot(0, 0, 'ko')  # Origin
    ax.set_aspect('equal')
    ax.set_title(label)
    ax.grid(True)

# Set up figure
fig, axs = plt.subplots(1, 3, figsize=(18, 6))

plot_spiral(axs[0], z1, "z₁(t) [1×freq]", cmap='Blues')
plot_spiral(axs[1], z2, "z₂(t) [2×freq]", cmap='Greens')
plot_spiral(axs[2], z3, "z₃(t) [3×freq]", cmap='Reds')

plt.tight_layout()
plt.show()
