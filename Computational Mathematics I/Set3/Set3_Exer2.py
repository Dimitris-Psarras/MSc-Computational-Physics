# -*- coding: utf-8 -*-
"""
Created on Fri Jan 21 12:01:18 2022

@author: dipsa
"""

import numpy as np
import sympy as sp
import matplotlib.pyplot as plt

def Euler(yd,h_a,t_a,y0):
    euler = 'Euler\'s method'
    y, t = sp.symbols('y, t')
    n = len(h_a)
    points = []
    yn = y0
    for i in range(n):
        h = h_a[i]
        t_all = np.linspace(t_a[0],t_a[1],int((t_a[1]-t_a[0])/h)+1)
        for xn in t_all:
            yn1 = yn + h*(yd.subs([(t,xn),(y,yn)]))
            points.append(yn)
            yn = yn1
            
        print_function(points,t_all,h,euler)
        print(f'The points of x and y are:\nx: {t_all}\ny: {points}')
        
        yn1 = 0
        yn = y0
        points = []
    return

def Runge_Kutta(yd,h_a,t_a,y0):
    RK4 = 'Runge Kutta 4th order method'
    y, t = sp.symbols('y, t')
    n = len(h_a)
    points = []
    yn = y0
    for i in range(n):
        h = h_a[i]
        t_all = np.linspace(t_a[0],t_a[1],int((t_a[1]-t_a[0])/h)+1)
        for xn in t_all:
            k1 = h*yd.subs([(t,xn),(y,yn)])
            k2 = h*yd.subs([(t,xn+(h/2)),(y,yn+(k1/2))])
            k3 = h*yd.subs([(t,xn+(h/2)),(y,yn+(k2/2))])
            k4 = h*yd.subs([(t,xn+h),(y,yn+k3)])
            yn1 = yn + (1/6)*(k1 + 2*k2 + 2*k3 +k4)
            points.append(yn)
            yn = yn1
            
        print_function(points,t_all,h,RK4)
        print(f'The points of x and y are:\nx: {t_all}\ny: {points}')
        
        yn1 = 0
        yn = y0
        points = []
    return

def print_function(y,x,h,s):
    plt.figure()
    plt.plot(x,y, linewidth=2)
    plt.title(f'Numerical Solution for dy/dx=yt^2-1.1y in x=[0,2]\n{s} h={h}')
    plt.xlabel('x')
    plt.ylabel('y')
    plt.grid()
    return

y, t = sp.symbols('y, t')
y_dot = y*t**2 - 1.1*y

y0 = 1
t = np.array([0.0, 2.0])
h = np.array([0.5, 0.25])

Euler(y_dot,h,t,y0)
Runge_Kutta(y_dot,h,t,y0)