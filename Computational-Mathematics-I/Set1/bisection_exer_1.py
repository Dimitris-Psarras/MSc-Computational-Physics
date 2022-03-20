# -*- coding: utf-8 -*-
"""
Created on Tue Dec 28 14:05:37 2021

@author: dipsa
"""

import sympy as sp

def bisection(x1,x2,y):
    i = True
    j=0
    while i:
        y1 = y.subs(x,x1)
        m = (x1+x2)/2
        ym = y.subs(x,m)
        if y1*ym<0:
            x2 = m
        else:
            x1 = m
        if abs(x1-x2)<10**(-10):
            i = False
        j=j+1
    return m,j


x = sp.symbols('x') 

y = sp.exp(x)-2*x*sp.cos(x)-3

sp.plot(y,(x,0,2), ylabel='y', xlabel='x')

x1 = 1.00
x2 = 1.50

riza, iterations = bisection(x1,x2,y)

print('riza einai %.10f\n' % (riza))
print(f'iterations {iterations}\n')

y = x**2+sp.sin(x)+sp.exp(x)-2

sp.plot(y,(x,0,1), ylabel='y', xlabel='x')

x1 = 0.2
x2 = 0.5

riza, iterations = bisection(x1,x2,y)

print('riza einai %.10f\n' % (riza))
print(f'iterations {iterations}\n')