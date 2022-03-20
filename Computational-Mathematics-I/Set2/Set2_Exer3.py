# -*- coding: utf-8 -*-
"""
Created on Thu Jan  6 17:43:14 2022

@author: dipsa
"""

import numpy as np
import math

def truncate(number, digits) -> float:
    stepper = 10.0 ** digits
    return math.trunc(stepper * number) / stepper

def Power_Method(A_k,k,a):
    l_prev = 0
    for i in range(1,k+1,1):
        X_k_prev = A_k.dot(X)
        A_k = A_k.dot(A)
        X_k = A_k.dot(X)
        l = np.amax(X_k)/np.amax(X_k_prev)
        if abs(l - l_prev) < pow(10,-a):
            break
        l_prev = l
    
    max_v = np.amax(X_k)
    l_vector = X_k/max_v
    
    return l, l_vector, i


A = np.array([[4.0, 1.0, 2.0, 1.0],
              [1.0, 7.0, 1.0, 0.0],
              [2.0, 1.0, 4.0, 1.0],
              [1.0, 0.0, 1.0, 3.0]])
X = np.array([[8.0],[9.0],[8.0],[4.0]])
ac = 5
max_iter = 100

eigenvalue, eigenvector, iteration = Power_Method(A,max_iter,ac)

print(f'The largest eigenvalue of the matrix\n{A}\nis: {truncate(eigenvalue,ac-1)}')
print(f'Calculation was completed after {iteration} iterations.')
print(f'The corresponding eigenvector is:\n{eigenvector}')