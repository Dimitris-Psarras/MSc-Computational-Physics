# -*- coding: utf-8 -*-
"""
Created on Wed Dec 29 23:24:20 2021

@author: dipsa
"""

import sympy as sp
import numpy as np
import matplotlib.pyplot as plt
import math

def truncate(number, digits) -> float:
    stepper = 10.0 ** digits
    return math.trunc(stepper * number) / stepper

def div_diff(x,y,n):
    table = np.zeros((n,n))
    for i in range(0,n):
        for j in range(0,n-i):
            if i!=0:
                table[j][i] = (table[j+1][i-1]-table[j][i-1])/(x[i+j]-x[j])
            else:
                table[j][i] = y[j]
    a = table[np.arange(0,n)][0]
    Print_Table(table,x)
    return a

def Print_Table(Table,x):
    print('\n-------------------------------------------Table of Divided Differences------------------------------------------')
    print("{:<5} |{:<10} |{:<15} |{:<18} |{:<18} |{:<18} |{:<18}".format("x","f(x)","First Div Diff.","Second Div Diff.","Third Div Diff.","Forth Div Diff.","Fifth Div Diff.")) 
    print('-----------------------------------------------------------------------------------------------------------------')
    for i in range(len(Table)):
        print("{:<5} |{:<10} |{:<15} |{:<18} |{:<18} |{:<18} |{:<18}".format(x[i],Table[i][0], truncate(Table[i][1],6), truncate(Table[i][2],6), truncate(Table[i][3],6), truncate(Table[i][4],6),truncate(Table[i][5],6)))
    return

def Newton(x, y, n):
    sym_x = sp.symbols('x')
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
    return P

def Plot_Polynomial(P,y_points,x_points,n):
    x = sp.symbols('x') 
    
    p1 = sp.plot(P,(x,x_points[0]-0.1,x_points[n-1]+0.05), show = False)
    x1, y1 = p1[0].get_points()
    
    plt.figure()
    plt.plot(x1,y1,label=r'Newtons divided differences formula')
    plt.scatter(x_points,y_points,label=r'data points', c ="red")
    plt.title('Interpolationg Polynomial: Newton\'s divided differences formula')
    plt.legend()
    plt.grid()
    return

x = sp.symbols('x') 

x_points = np.array([0.2, 0.3, 0.4, 0.5, 0.6, 0.7])
y_points = np.array([0.185, 0.106, 0.093, 0.240, 0.579, 0.561])

n = len(y_points)

P = Newton(x_points,y_points,n)

print(f'\nThe Newton\'s divided differences formula yields the interpolating polynomial:\n {P}')

Plot_Polynomial(P,y_points,x_points,n)

