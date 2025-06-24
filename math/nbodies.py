import numpy as np
import matplotlib.pyplot as plt

# Time and parameters
t = np.linspace(-1, 1, 1000)
r_vals = [0.5, 1.0, 1.5]  # Different radii
v = 0.8  # Fixed vector/direction value

# Colors and labels for plots
colors = ['magenta', 'cyan', 'lime']
labels = [
    "Formula 1: sin + cos",
    "Formula 2: cos + sin",
    "Formula 3: tan + cos",
    "Formula 4: tan + sin"
]

# Prepare plot
fig, ax = plt.subplots(2, 2, figsize=(12, 10))
ax = ax.flatten()

# Iterate over each formula
for i in range(4):
    for r, color in zip(r_vals, colors):
        p = r * (np.cos(2 * np.pi * t) + 1j * np.sin(2 * np.pi * t))
        if i == 0:
            y = (p / (1 + v * np.cos(2 * np.pi * t))) * np.sin(2 * np.pi * t) + np.cos(2 * np.pi * t)
        elif i == 1:
            y = (p / (1 + v * np.cos(2 * np.pi * t))) * np.cos(2 * np.pi * t) + np.sin(2 * np.pi * t)
        elif i == 2:
            y = (p / (1 + v * np.cos(2 * np.pi * t))) * np.tan(2 * np.pi * t) + np.cos(2 * np.pi * t)
        elif i == 3:
            y = (p / (1 + v * np.sin(2 * np.pi * t))) * np.tan(2 * np.pi * t) + np.sin(2 * np.pi * t)
        y = np.where(np.abs(y.real) > 1e2, np.nan, y)
        ax[i].plot(t, y.real, color=color, label=f"r = {r}")
    
    ax[i].set_title(labels[i])
    ax[i].set_xlim(-1, 1)
    ax[i].grid(True)
    ax[i].legend()

plt.tight_layout()
plt.show()
