import numpy as np
import matplotlib.pyplot as plt

# Constants
phi = (1 + np.sqrt(5)) / 2
sqrt_5 = np.sqrt(5)

# Generate Fibonacci numbers via Binet's Formula
def fibonacci(n):
    return (phi**n - (1 - phi)**n) / sqrt_5

n_vals = np.arange(1, 30)  # Fib terms
fib_vals = fibonacci(n_vals)

# Time values
t_vals = np.linspace(0, 1, 500)
theta_vals = 2 * np.pi * t_vals

# Prepare complex spirals
fig, ax = plt.subplots(figsize=(8, 8))
colors = plt.cm.viridis(np.linspace(0, 1, len(fib_vals)))

for i, (n, fib) in enumerate(zip(n_vals, fib_vals)):
    x = fib * t_vals * np.cos(theta_vals)
    y = fib * t_vals * np.sin(theta_vals)
    ax.plot(x, y, color=colors[i], label=f'n={n}' if i % 5 == 0 else '')

ax.set_aspect('equal')
ax.set_title("Fibonacci * Euler Spiral (over t ∈ [0,1])")
ax.grid(True)
ax.legend()
plt.show()
