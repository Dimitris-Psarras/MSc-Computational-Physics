# -*- coding: utf-8 -*-
"""
Created on Wed Dec 29 15:48:49 2021

@author: dipsa
"""

import sympy as sp
import matplotlib.pyplot as plt

x = sp.symbols('x') 

y = 2*sp.exp(x)-3*x**2
g1 = sp.sqrt((2*sp.exp(x))/3)
g2 = -sp.sqrt((2*sp.exp(x))/3)
p1 = sp.plot(g1,(x,-1,1), ylabel='y', xlabel='x', show=False, label = 'f', line_color = 'r')
p2 = sp.plot(g2,(x,-1,1), ylabel='y', xlabel='x', show=False, line_color = 'm')
p3 = sp.plot(x,(x,-1,1), ylabel='y', xlabel='x', show=False, line_color = 'b')

x1, y1 = p1[0].get_points()
x2, y2 = p2[0].get_points()
x3, y3 = p3[0].get_points()

plt.figure()
plt.plot(x1,y1,label=r'$g(x)=\sqrt{\frac{2e^{x}}{3}}$')
plt.plot(x2,y2,label=r'$y(x)=-\sqrt{\frac{2e^{x}}{3}}$')
plt.plot(x3,y3,label=r'$y(x)=x$')
plt.title(r'Plots for checking convergence for $g(x)=\pm\sqrt{\frac{2e^{x}}{3}}$')
plt.legend()
plt.grid()

g = (-2*sp.sqrt(2*sp.exp(x)/3)+x)/3
g_dot = sp.diff(g,x)
print(g_dot)

p4 = sp.plot(g,(x,-1,1), ylabel='y', xlabel='x', show=False, line_color = 'r')
x4, y4 = p4[0].get_points()

plt.figure()
plt.plot(x4,y4,label=r'$g(x)=\frac{x-2\sqrt{\frac{2e^{x}}{3}}}{3}$')
plt.plot(x3,y3,label=r'$y(x)=x$')
plt.title(r'Plots for checking convergence for $g(x)=\frac{x-2\sqrt{\frac{2e^{x}}{3}}}{3}$')
plt.legend()
plt.grid()


p5 = sp.plot(abs(g_dot),(x,-1,1), ylabel='y', xlabel='x', show = False)
x5, y5 = p5[0].get_points()

plt.figure()
plt.plot(x5,y5,label=r'$g\'(x)=\frac{3-\sqrt{6e^{x}}}{9}$')
plt.title(r'Convergence for |g\'(x)|<1')
plt.legend()
plt.grid()