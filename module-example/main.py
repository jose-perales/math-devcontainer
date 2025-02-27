import numpy as np
import matplotlib.pyplot as plt

# Define the function e^(-x)
def f(x):
    return np.exp(-x)

# Generate x values from 0 to 10 (as infinity is not practical)
x = np.linspace(0, 10, 400)
y = f(x)

# Calculate the integral using numpy's cumulative trapezoidal rule
integral = np.cumsum(y) * (x[1] - x[0])

# Plot the function
plt.plot(x, y, label='$e^{-x}$')
plt.fill_between(x, y, alpha=0.2)

# Plot the integral
plt.plot(x, integral, label='$\int_0^{\infty}e^{-x}\,dx$', linestyle='--')

# Add labels and legend
plt.xlabel('x')
plt.ylabel('y')
plt.title('Plot $y=\int_0^{\infty}e^{-x}\,dx$ and $y=e^{-x}$')
plt.legend()

# Save the plot
plt.savefig("/workspace/module-example/software-assignment.png")