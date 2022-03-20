# -*- coding: utf-8 -*-
"""
Created on Fri Jan 21 01:49:05 2022

@author: dipsa
"""

import numpy as np
import sympy as sp
import matplotlib.pyplot as plt
from matplotlib.patches import Polygon
import math

def function(x):
    return x*math.exp(2*x)

def plot_integrated_func(y,r):
    x = sp.symbols('x') 
    left, width = .3, .5
    bottom = .2
    right = left + width
    
    p1 = sp.plot(y,(x,r[0],r[1]), ylabel='y', xlabel='x', show = False)
    x1, y1 = p1[0].get_points()
    
    fig, ax = plt.subplots()
    ax.plot(x1,y1,label=r'$y(x)=xe^{2x}$', linewidth=2)
    ax.set_ylim(bottom=0)
    plt.title('Function to integrate')
    plt.xlabel('x')
    plt.ylabel('y')
    plt.legend()
    plt.grid()

    ix = np.linspace(r[0], r[1])
    iy = ix*np.exp(2*ix)
    verts = [(r[0], 0), *zip(ix, iy), (r[1], 0)]
    poly = Polygon(verts, facecolor='0.9', edgecolor='0.5')
    ax.add_patch(poly)

    ax.text(right, bottom, r"$\int_0^3 xe^{2x}\mathrm{d}x$",
            horizontalalignment='center',verticalalignment='top',transform=ax.transAxes, fontsize=20)

    plt.show()
    return

def simpson_h3(r,n):
    h = (r[1]-r[0])/n
    m = r[0]+h
    In = (h/3)*(function(r[0])+4*function(m)+function(r[1]))
    return In

def simpson_h3_8(r,n):
    if n%2 != 0:
        raise ValueError('Simpson\'s h/3 rule only works for an even number of segments (n).')
    sum_even = 0.0
    sum_odd = 0.0
    h = (r[1]-r[0])/n
    print(f'h = {h}\n')
    dx = np.linspace(r[0],r[1],n+1)
    for i in range(1,n):
        if (i%2 != 1):
           sum_even += function(dx[i])
        else:
           sum_odd += function(dx[i])
        
    In = (h/3)*(function(r[0])+4*sum_odd+2*sum_even+function(r[1]))
    return In


x = sp.symbols('x') 
f = x*sp.exp(2*x)

x = np.array([0, 3])
n = np.array([2, 8])

plot_integrated_func(f,x)

I1 = simpson_h3(x,n[0])
I2 = simpson_h3_8(x,n[1])

print(f'Using the simple Simpson\'s h/3 rule the integral is calculated,\nI = {I1}\n')
print(f'Using the same rule with n = 8 the integral is calculated,\nI = {I2}')