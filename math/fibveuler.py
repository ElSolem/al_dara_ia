import matplotlib.pyplot as plt
import numpy as np

# Set up range
r_values = np.linspace(0, 10, 1000)
n_values = np.arange(1, 50)

# Constants
phi = (1 + np.sqrt(5)) / 2
golden_angle = 2 * np.pi * (1 - 1 / phi)

# Archimedean spiral
x_arch = r_values * np.cos(2 * np.pi * r_values)
y_arch = r_values * np.sin(2 * np.pi * r_values)

# Golden spiral (Fibonacci-based)
fib = [0, 1]
for i in range(2, len(n_values) + 2):
    fib.append(fib[-1] + fib[-2])
fib = np.array(fib[2:])  # Trim first two for plotting

theta_golden = golden_angle * n_values
x_golden = fib * np.cos(theta_golden)
y_golden = fib * np.sin(theta_golden)

# Plot
plt.figure(figsize=(10, 5))
plt.subplot(1, 2, 1)
plt.plot(x_arch, y_arch, color='royalblue')
plt.title("Archimedean Spiral\n$e^{i 2\\pi r} \\cdot r$")
plt.axis('equal')
plt.grid(True)

plt.subplot(1, 2, 2)
plt.scatter(x_golden, y_golden, color='goldenrod')
plt.title("Golden Spiral (Fibonacci)\n$F(n) \\cdot e^{i n \\theta}$")
plt.axis('equal')
plt.grid(True)

plt.tight_layout()
plt.show()
