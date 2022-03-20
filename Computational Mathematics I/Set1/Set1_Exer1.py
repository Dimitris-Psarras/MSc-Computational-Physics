# -*- coding: utf-8 -*-
"""
Created on Tue Dec 28 23:55:10 2021

@author: dipsa
"""

import sympy as sp
import matplotlib.pyplot as plt
import math

def truncate(number, digits) -> float:
    stepper = 10.0 ** digits
    return math.trunc(stepper * number) / stepper

def NewtonRaphson(x_n,y,y_dot,ac):
    i = True
    j=0
    print('NEWTON RAPHSON METHOD TABLE')
    while i:
        y0 = y.subs(x,x_n)
        y0_dot = y_dot.subs(x,x_n)
        x_n_1 = x_n - (y0/y0_dot)
        if abs(x_n_1-x_n)<pow(10,-ac):
            i = False
        j=j+1
        if j>1:
            ea = abs(((x_n_1-x_n)/x_n_1)*100)
            print(f'{x_n_1 = :.10f} x_n = {truncate(x_n,ac) :.10f} and {ea = :.10f}')
        x_n = x_n_1
    return x_n_1,j

def bisection(x1,x2,y,ac):
    i = True
    j=0
    print('BISECTION METHOD TABLE')
    while i:
        y1 = y.subs(x,x1)
        m = (x1+x2)/2
        ym = y.subs(x,m)
        if y1*ym<0:
            x2 = m
        else:
            x1 = m
        if abs(x1-x2)<pow(10,-ac):
            i = False
        j=j+1
        if j==1:
            xr_old = m
        else:
            ea = abs(((m-xr_old)/m)*100)
            xr_old = m
            print(f'x_lower = {truncate(x1,ac):.10f} x_upper = {truncate(x2,ac):.10f}, x_r = {truncate(m,ac):.10f} and  e_a = {truncate(ea,ac):.10f}')
    return m,j

ac = 10

x = sp.symbols('x') 

y = sp.exp(x)-2*x*sp.cos(x)-3
y_dot = sp.diff(y,x)

p1 = sp.plot(y,(x,0,2), ylabel='y', xlabel='x', show = False)
x1, y1 = p1[0].get_points()
plt.figure()
plt.plot(x1,y1,label=r'$y(x)=e^{x}-2Cos(x)-3$')
plt.title(r'Plot of y(x) function')
plt.legend()
plt.grid()

x1 = 0.00
x2 = 2.00

riza, iterations = bisection(x1,x2,y,ac)

it = math.ceil(math.log((x2-x1)/ac,2))
print('A. Bisection Method:')
print(f'Expected number of iteretions: {it}')
print('\nRoot of function is x = %.10f for accuracy 10^{-10}.\n' % (truncate(riza,ac)))
print(f'The root was found after {iterations} iterations.\n')

x0 = 2.0

riza, iterations = NewtonRaphson(x0,y,y_dot,ac)

print('A. Newton Raphson Method:')
print('\nRoot of function is x = %.10f for accuracy 10^{-10}.\n' % (truncate(riza,ac)))
print(f'The root was found after {iterations} iterations.\n')

y = x**2+sp.sin(x)+sp.exp(x)-2
y_dot = sp.diff(y,x)

p2 = sp.plot(y,(x,0,1), ylabel='y', xlabel='x', show = False)
x2, y2 = p2[0].get_points()
plt.figure()
plt.plot(x2,y2,label=r'$y(x)=x^{2}+Sin(x)+e^{x}-2$')
plt.title(r'Plot of y(x) function')
plt.legend()
plt.grid()

x1 = 0.2
x2 = 0.5

riza, iterations = bisection(x1,x2,y,ac)

it = math.ceil(math.log((x2-x1)/ac,2))
print('B. Bisection Method:')
print(f'Expected number of iteretions: {it}')
print('\nRoot of function is x = %.10f for accuracy 10^{-10}.\n' % (truncate(riza,ac)))
print(f'The root was found after {iterations} iterations.\n')

x0 = 0.5

riza, iterations = NewtonRaphson(x0,y,y_dot,ac)

print('B. Newton Raphson Method:')
print('\nRoot of function is x = %.10f for accuracy 10^{-10}.\n' % (truncate(riza,ac)))
print(f'The root was found after {iterations} iterations.\n')