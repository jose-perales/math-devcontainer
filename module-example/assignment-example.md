---
title: "Module Example Assignment"
subtitle: "Chapter X, Sections Y-Z"
author: Your Name
date: Date Assignment is Due
graphics: yes 
---
<!-- markdownlint-disable MD036 -->

## Problem Set

**X.Y.1 Some exercise from the textbook that likely has inline latex like $\boldsymbol{\int_0^{\infty} e^{-x} \,dx}$.**

The answer to the exercise generally has inline latex as well like $\int_0^{\infty} e^{-x} \,dx$. Often times there are lines like the following which are all latex,

$$\int_0^{\infty} e^{-x} \,dx = \left[ e^x \right]_0^{\infty}=\lim_{x \to \infty}\left( -e^{-x} \right) - \left( -e^{-0} \right) = 0 - (-1) = 1$$

\pagebreak

## Software Assignment

**Some prompt assigned as a software assignment. For example, create a visualization representing $\boldsymbol{\int_0^{\infty} e^{-x} \,dx}$.**

\begin{figure}[htbp]\includegraphics[width=1\textwidth, height=!]{module-example/software-assignment.png}\centering\end{figure}

```Python
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
```
