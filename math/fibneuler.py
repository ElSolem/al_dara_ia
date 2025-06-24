import numpy as np
import matplotlib.pyplot as plt

# Euler Spiral: (cos(2πr) + i*sin(2πr)) * r
r_vals = np.linspace(0, 10, 1000)
theta_euler = 2 * np.pi * r_vals
x_euler = r_vals * np.cos(theta_euler)
y_euler = r_vals * np.sin(theta_euler)

# Fibonacci Spiral: Discrete points mapped with golden angle (approx. 137.5 degrees)
golden_angle = np.pi * (3 - np.sqrt(5))  # in radians (~137.5 degrees)
n_fib = 100
r_fib = np.sqrt(np.arange(n_fib))  # Square root spacing for radial growth
theta_fib = golden_angle * np.arange(n_fib)
x_fib = r_fib * np.cos(theta_fib)
y_fib = r_fib * np.sin(theta_fib)

# Plot both
fig, ax = plt.subplots(figsize=(10, 5))
ax.plot(x_euler, y_euler, label="Euler Spiral (2πr)", color='cyan')
ax.scatter(x_fib, y_fib, label="Fibonacci Spiral", color='gold', s=10)
ax.set_aspect('equal')
ax.set_title("Euler Spiral vs Fibonacci Spiral")
ax.legend()
ax.grid(True)

plt.show()
