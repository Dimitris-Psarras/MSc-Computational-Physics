# -*- coding: utf-8 -*-
"""
Created on Wed Dec 29 17:26:04 2021

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
            print('x_n_1 = %.10f x_n = %.10f and  e_a = %.10f' %(truncate(x_n_1,ac), truncate(x_n,ac), truncate(ea,ac)))
        x_n = x_n_1
    return x_n_1,j

def x_gx(xi,g,ac):
    i = True
    j=0
    print('X=g(X) METHOD TABLE')
    while i:
        j=j+1
        x_i1 = g.evalf(subs={x: xi})
        ea = abs(((x_i1-xi)/x_i1)*100)
        print(f'x_i1 = {truncate(x_i1,10) :.10f} xi = {truncate(xi,10) :.10f} and ea = {truncate(ea,10) :.10f}')
        if abs(x_i1-xi)<pow(10,-ac):
                i = False
        xi = x_i1
        if j>100:
            i = False
    return x_i1,j

ac = 10

x = sp.symbols('x') 

y = 2*sp.exp(x)-3*x**2
g = (-2*sp.sqrt(2*sp.exp(x)/3)+x)/3
y_dot = sp.diff(y,x)

p1 = sp.plot(y,(x,-1,1), ylabel='y', xlabel='x',show = False)
x1, y1 = p1[0].get_points()
plt.figure()
plt.plot(x1,y1,label=r'$y(x)=2e^{x}-3x^{2}$')
plt.title(r'Plot of y(x) function')
plt.legend()
plt.grid()

x_0 = -0.50

riza, iterations = x_gx(x_0,g,ac)

print('1. x=g(x) Method:')
print(f'\nRoot of function is x = {truncate(riza,10) :.10f} for accuracy {pow(10,-ac): .2E}.\n')
print(f'The root was found after {iterations} iterations.\n')

x0 = -0.5

riza, iterations = NewtonRaphson(x0,y,y_dot,ac)

print('2. Newton Raphson Method:')
print(f'\nRoot of function is x = {truncate(riza,10) :.10f} for accuracy {pow(10,-ac): .2E}.\n')
print(f'The root was found after {iterations} iterations.\n')