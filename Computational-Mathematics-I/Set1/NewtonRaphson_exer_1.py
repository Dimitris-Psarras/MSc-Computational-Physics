# -*- coding: utf-8 -*-
"""
Created on Tue Dec 28 22:44:30 2021

@author: dipsa
"""

import sympy as sp

def NewtonRaphson(xn,y,y_dot):
    i = True
    j=0
    while i:
        y0 = y.subs(x,xn)
        y0_dot = y_dot.subs(x,xn)
        xn_1 = xn - (y0/y0_dot)
        if abs(xn_1-xn)<10**(-10):
            i = False
        xn = xn_1
        j=j+1
    return xn_1,j


x = sp.symbols('x') 

y = sp.exp(x)-2*x*sp.cos(x)-3
y_dot = sp.diff(y,x) 

sp.plot(y,(x,0,2), ylabel='y', xlabel='x')

x0 = 2.0

riza, iterations = NewtonRaphson(x0,y,y_dot)

print('riza einai %.10f\n' % (riza))
print(f'iterations {iterations}\n')

y = x**2+sp.sin(x)+sp.exp(x)-2
y_dot = sp.diff(y,x)

sp.plot(y,(x,0,1), ylabel='y', xlabel='x')

x0 = 0.5

riza, iterations = NewtonRaphson(x0,y,y_dot)

print('riza einai %.10f\n' % (riza))
print(f'iterations {iterations}\n')