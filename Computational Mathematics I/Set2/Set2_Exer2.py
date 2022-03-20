# -*- coding: utf-8 -*-
"""
Created on Fri Jan  7 00:43:55 2022

@author: dipsa
"""

import sympy as sp
import numpy as np
import matplotlib.pyplot as plt
import math

def truncate(number, digits) -> float:
    stepper = 10.0 ** digits
    return math.trunc(stepper * number) / stepper

def Forward_diff(y,h):
    i = 0
    y_diff = (-y[i+2]+4*y[i+1]-3*y[i])/(2*h)
    return y_diff

def Backward_diff(y,h):
    i = len(y)-1
    y_diff = (y[i-2]-4*y[i-1]+3*y[i])/(2*h)
    return y_diff

def Central_diff(y,h):
    y_diff = np.zeros(len(y)-2)
    for i in range(1,len(y)-1):
        y_diff[i-1] = (y[i+1]-y[i-1])/(2*h)
    return y_diff

def Differentiation(x,y,y_actual):
    col = len(y)
    y_diff = np.zeros(col)
    h = round(x[1] - x[0],3)
    for i in range(1,col):
        if round(x[i]-x[i-1]-h,1)!=0.0:
            print('Warning: Data not equally spaced')
    y_diff[0] = Forward_diff(y_points,h)
    y_diff[col-1] = Backward_diff(y_points,h)
    y_diff[1:col-1] = Central_diff(y_points,h)
    P = Newton(x,y,y_actual)
    Diff_Pol = Polynomial_Diff(P,x,col)
    Diff_Actual = Actual_Diff(y_actual,col)
    Diffs = np.concatenate((x.reshape((col,1)),y.reshape((col,1)),y_diff.reshape((col,1)),Diff_Pol.reshape((col,1)),Diff_Actual.reshape((col,1))),axis = 1)
    return Diffs

def div_diff(x,y,n):
    table = np.zeros((n,n))
    for i in range(0,n):
        for j in range(0,n-i):
            if i!=0:
                table[j][i] = (table[j+1][i-1]-table[j][i-1])/(x[i+j]-x[j])
            else:
                table[j][i] = y[j]
    a = table[np.arange(0,n)][0]
    return a

def Newton(x, y,y_a):
    sym_x = sp.symbols('x')
    n = len(y)
    P = 0
    L1 = 1
    a = div_diff(x,y,n)
    for i in range(0,n):
        for j in range(0,i):
            l1 = sym_x - x[j]
            L1 = L1*l1
        L = a[i]*L1
        P = P + L
        L1 = 1
    P = sp.expand(P)
    Plot_Polynomial(P,y,x,n,y_a)
    return P

def Plot_Polynomial(Pol,y_val,x_val,n,y):
    x = sp.symbols('x') 
    
    p1 = sp.plot(Pol,(x,x_val[0]-0.1,x_val[n-1]+0.05), show = False)
    x1, y1 = p1[0].get_points()
     
    p2 = sp.plot(y,(x,1.7,2.3), ylabel='y', xlabel='x', show = False)
    x2, y2 = p2[0].get_points()
    
    plt.figure()
    plt.plot(x1,y1,label=r'Newtons divided differences formula')
    plt.plot(x2,y2,label=r'$y(x)=xe^{x}$')
    plt.scatter(x_val,y_val,label=r'data points', c ="red")
    plt.title('Interpolationg Polynomial: Newton\'s divided differences formula')
    plt.legend()
    plt.grid()
    return

def Polynomial_Diff(Pol,x_points,n):
    P_dot = sp.diff(Pol,x)
    y_dot_num = np.zeros(n)
    for i in range(n):
        y_dot_num[i] = P_dot.subs(x,x_points[i])
    return y_dot_num

def Actual_Diff(y,n):
    y_dot = sp.diff(y,x)
    y_dot_anal = np.zeros(n)
    for i in range(n):
        y_dot_anal[i] = y_dot.subs(x,x_points[i])
    return y_dot_anal

def Print_Table(Table):
    print('\n----------------------------Table of Differentiation----------------------------')
    print("{:<5} |{:<10} |{:<15} |{:<18} |{:<18}".format("x","f(x)","f'(x) Num. Diff.","f'(x) Interpolating Pol.","f'(x) actual")) 
    print('--------------------------------------------------------------------------------')
    for i in range(len(Table)):
        print("{:<5} |{:<10} |{:<16} |{:<24} |{:<18}".format(Table[i][0], Table[i][1], truncate(Table[i][2],6), truncate(Table[i][3],6), truncate(Table[i][4],6)))
    return

x = sp.symbols('x')
y = x*sp.exp(x)

x_points = np.array([1.8, 1.9, 2.0, 2.1, 2.2])
y_points = np.array([10.889365, 12.703199, 14.778112, 17.148957, 19.855030])

Table_diff = Differentiation(x_points,y_points,y)

Print_Table(Table_diff)