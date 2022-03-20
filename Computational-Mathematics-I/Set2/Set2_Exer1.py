# -*- coding: utf-8 -*-
"""
Created on Wed Jan  5 23:53:14 2022

@author: dipsa
"""

import numpy as np

def Gaussian_Elimination(Aug,r,c):
    X = np.zeros(r)
    for i in range(c-1):
        Aug = Pivoting(Aug,i)
        for j in range(i+1,r):
            xn = Aug[j][i]/Aug[i][i]
            Aug[[j]]=C[[j]]-(Aug[[i]]*xn)
            
    for i in range(r-1,-1,-1):
        b = Aug[i][-1]
        for j in range(c):
            if i!=j:
                b = b - (Aug[i][j]*X[j])
        X[i] = b/Aug[i][i]
    return X

def Pivoting(Aug,c_c):
    Aug_P = np.absolute(Aug)
    l = len(Aug_P)
    max_v = Aug_P[c_c][c_c]
    p = c_c
    for i in range(c_c+1,l):
        if Aug_P[i][c_c]>max_v:
            max_v = Aug_P[i][c_c]
            p = i
    temp = Aug[[c_c]]
    Aug[[c_c]] = Aug[[p]]
    Aug[[p]] = temp
    return Aug

A = np.array([[1.0, -1.0, 2.0, -1.0],[2.0, -2.0, +3.0, -3.0],[1.0, 1.0, 1.0, 0.0],[1.0, -1.0, +4.0, +3.0]])
B = np.array([[-8.0],[-20.0],[-2.0],[4.0]])
C = np.append(A,B, axis=1)

rows = len(A)
columns = len(A[0])

X = Gaussian_Elimination(C, rows, columns)
    
print('The solution vector is: ')
print(X)
print('\nAnalytically the solution is: ')
for i in range(len(X)):
    print(f'x_{i} = {round(X[i],5)}')