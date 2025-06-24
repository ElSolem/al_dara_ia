import numpy as np
import matplotlib.pyplot as plt

# Define the angular frequency and time
w = 2 * np.pi
t_vals = np.linspace(-10, 10, 1000)

# Define the functions from the expressions
def complex_expr_1(w, t):  # (abs(wt) + i*abs(wt)) * t
    return t * (np.abs(w*t) + 1j * np.abs(w*t))

def complex_expr_2(w, t):  # (abs(wt) * i*abs(wt)) * t
    return t * (np.abs(w*t) * 1j * np.abs(w*t))

def complex_expr_3(w, t):  # i*(abs(wt) * i*abs(wt)) * t
    return t * (1j * (np.abs(w*t) * 1j * np.abs(w*t)))

def complex_expr_4(w, t):  # (abs(wt) - i*abs(wt)) * t
    return t * (np.abs(w*t) - 1j * np.abs(w*t))

def complex_expr_5(w, t):  # (abs(wt) ** (i * abs(wt))) * t
    return t * (np.abs(w*t) ** (1j * np.abs(w*t)))

# Compute the expressions
z1 = complex_expr_1(w, t_vals)
z2 = complex_expr_2(w, t_vals)
z3 = complex_expr_3(w, t_vals)
z4 = complex_expr_4(w, t_vals)
z5 = complex_expr_5(w, t_vals)

# Plot the complex paths
plt.figure(figsize=(12, 8))
plt.plot(z1.real, z1.imag, label="(abs(wt) + i*abs(wt)) * t")
plt.plot(z2.real, z2.imag, label="(abs(wt) * i*abs(wt)) * t")
plt.plot(z3.real, z3.imag, label="i*(abs(wt) * i*abs(wt)) * t")
plt.plot(z4.real, z4.imag, label="(abs(wt) - i*abs(wt)) * t")
plt.plot(z5.real, z5.imag, label="(abs(wt) ** (i*abs(wt))) * t")

plt.xlim(-10, 10)
plt.ylim(-10, 10)
plt.axhline(0, color='gray', linewidth=0.5)
plt.axvline(0, color='gray', linewidth=0.5)
plt.gca().set_aspect('equal')
plt.title("Complex Paths of Parametric Expressions")
plt.legend()
plt.grid(True)
plt.tight_layout()
plt.show()
