# -*- coding: utf-8 -*-
"""
Created on Wed Dec 29 19:51:09 2021

@author: dipsa
"""

import sympy as sp
import numpy as np
import matplotlib.pyplot as plt
import math

def Lagrange(x, y, n):
    sym_x = sp.symbols('x')
    L_u = 1
    L_l = 1
    P = 0
    for i in range(0,n):
        L_u = 1
        L_l = 1
        for j in range(0,n):
            if i!=j:
                l1 = sym_x - x[j]
                l2 = x[i]-x[j]
                L_u = L_u*l1
                L_l = L_l*l2
        L = (L_u/L_l)*y[i]
        P = P + L
    return P

print('Exercise 3: y(x)=1+sin(πx)')
x = sp.symbols('x') 

# the x_points are set for the particular problem
x_points = np.arange(-1,2,1)

n = len(x_points)

# the y(x) function is set for the particular problem
y = 1+sp.sin(math.pi*x)
f = sp.lambdify(x, y, "numpy")
y_points = f(x_points)

P = Lagrange(x_points, y_points, n)
P = sp.simplify(P)

print(f'The Lagrange interpolation polynomial is: {P}')

# the the range of the plots is set for the particular problem
p1 = sp.plot(y,(x,-1.2,1.2), show = False)
p2 = sp.plot(P,(x,-1.2,1.2), show = False)
x1, y1 = p1[0].get_points()
x2, y2 = p2[0].get_points()

plt.figure()
plt.plot(x1,y1,label=r'$y(x)=1+sin(πx)$')
plt.plot(x2,y2,label=r'Lagrange P(x)')
plt.scatter(x_points,y_points,label=r'data points',c ="red")
plt.title(r'Interpolation: Lagrange Polynomial')
plt.legend()
plt.grid()

print('\nExercise 3: f(x)=2x**(1/2)')
x = sp.symbols('x') 

# the x_points are set for the particular problem
x_points = np.array([0,1,4])

n = len(x_points)

# the f(x) function is set for the particular problem
y = 2*x**(1/2)
f = sp.lambdify(x, y, "numpy")
y_points = f(x_points)

P = Lagrange(x_points, y_points, n)
P = sp.simplify(P)

print(f'The Lagrange interpolation polynomial is: {P}')


# the the range of the plots is set for the particular problem
p1 = sp.plot(y,(x,0,4.2), show = False)
p2 = sp.plot(P,(x,0,4.2), show = False)
x1, y1 = p1[0].get_points()
x2, y2 = p2[0].get_points()

plt.figure()
plt.plot(x1,y1,label=r'$f(x)=2x^{1/2}$')
plt.plot(x2,y2,label=r'Lagrange P(x)')
plt.scatter(x_points,y_points,label=r'data points',c ="red")
plt.title(r'Interpolation: Lagrange Polynomial')
plt.legend()
plt.grid()