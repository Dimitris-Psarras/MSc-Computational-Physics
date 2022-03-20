# Project 2: Rigid-Body Dynamics

# Import the necessary libraries
import sympy as sp
import numpy as np
from scipy import special
import matplotlib.pyplot as plt
from itertools import chain
import math

# Functions used in each Task
#------------------------------------------------------------------------------------------------------------------------------
# TASK 1:
# Jacobi's method for calculating the analytical solutions of Euler's equations
def Jacobi(w,I):
    # Energy and Torque(Angular Momentum)
    E02 = (I[0]*(w[0]**2) + I[1]*(w[1]**2) + I[2]*(w[2]**2))
    M2 = (I[0]**2)*(w[0]**2) + (I[1]**2)*(w[1]**2) + (I[2]**2)*(w[2]**2)
    
    # Jacobi elliptic functions
    t = t_int*math.sqrt(((I[2]-I[1])*(M2-E02*I[0]))/(I[0]*I[1]*I[2]))
    k2 = ((I[1]-I[0])*(E02*I[2]-M2))/((I[2]-I[1])*(M2-E02*I[0]))
    e = special.ellipj(t,k2)
    
    # Solution using Jacobi elliptic functions
    w1j = math.sqrt((E02*I[2]-M2)/(I[0]*(I[2]-I[0])))*e[1]
    w2j = math.sqrt((E02*I[2]-M2)/(I[1]*(I[2]-I[1])))*e[0]
    w3j = math.sqrt((M2-E02*I[0])/(I[2]*(I[2]-I[0])))*e[2]
    wj = [w1j,w2j,w3j]
    n = len(wj)
    wj = np.array(wj)
    wj = wj.T
    
    return wj, n, E02

# Function to calculate and plot the relative error in the energy log(|(E(t)-E(0))/(E(0))|)
def Error_calc_Jacobi(w,E0_2,t):
    e = []
    E0 = E0_2/2
    for i in range(len(w[1:])):
        i = i + 1
        E = ((I[0]*(w[i][0]**2) + I[1]*(w[i][1]**2) + I[2]*(w[i][2]**2))/2)
        e_part = np.log(abs((E-E0)/E0))
        e.append(e_part)
    
    # plot relative error
    plt.figure()
    plt.plot(t[1:],e)
    plt.title('Relative Error in the energy E(t) for the analytical solution\nUsing the jacobi elliptic functions')
    plt.xlabel('t')
    plt.ylabel('Relative Error')
    plt.grid()
    return

#------------------------------------------------------------------------------------------------------------------------------
# TASK 2
# Implemetation of RK4 (Runge Kutta 4th order)
def Runge_Kutta(wd,h,t_all,I,wn):
    # Define symbolic variables
    w1, w2, w3 = sp.symbols('w1, w2, w3')
    
    # Number of Differential Equations
    n = len(wd)
    
    # Initiallize matrix of initial condition w and matrix of w values (points)
    w0 = []
    wn1 = []
    points = []
    for iw in wn:
        w0.append(iw)
    points.append(w0)
    
    # RK4
    for xn in t_all[1:]:
        k0 = k(wd,wn,n,h)
        s0 = s(wd,wn,n,h,k0)
        l0 = l(wd,wn,n,h,s0)
        p0 = p(wd,wn,n,h,l0)
        for i in range(n):
            wn1_part = wn[i] + (1/6)*(k0[i] + 2*s0[i] + 2*l0[i] + p0[i])
            wn1.append(wn1_part)
        points.append(wn1)
        wn = wn1
        wn1 = []
    
    return points

# Compute all k for each equation
def k(wd,wn,n,dt):
    w1, w2, w3 = sp.symbols('w1, w2, w3')
    k = []
    for i in range(n):
        k1 = dt*wd[i].subs([(w1,wn[0]),(w2,wn[1]),(w3,wn[2])])
        k.append(k1)
    return k

# Compute all s for each equation
def s(wd,wn,n,dt,k):
    w1, w2, w3 = sp.symbols('w1, w2, w3')
    s = []
    for i in range(n):
        s1 = dt*wd[i].subs([(w1,wn[0]+(k[0]/2)),(w2,wn[1]+(k[1]/2)),(w3,wn[2]+(k[2]/2))])
        s.append(s1)
    return s

# Compute all l for each equation
def l(wd,wn,n,dt,s):
    w1, w2, w3 = sp.symbols('w1, w2, w3')
    l = []
    for i in range(n):
        l1 = dt*wd[i].subs([(w1,wn[0]+(s[0]/2)),(w2,wn[1]+(s[1]/2)),(w3,wn[2]+(s[2]/2))])
        l.append(l1)
    return l

# Compute all p for each equation
def p(wd,wn,n,dt,l):
    w1, w2, w3 = sp.symbols('w1, w2, w3')
    p = []
    for i in range(n):
        p1 = dt*wd[i].subs([(w1,wn[0]+l[0]),(w2,wn[1]+l[1]),(w3,wn[2]+l[2])])
        p.append(p1)
    return p

#------------------------------------------------------------------------------------------------------------------------------
# TASK 3
# Implemantation of splitting method. In this function each value of w is calculated.
def Splitting(ti,w,M,I,h):
    points = []
    # Splitting method
    for i in ti:
        if i == 0:
            points.append(w)
            continue
        
        w, M = fm_tot(n,M,I,h)
        points.append(w)
    
    return points

# Computation of the clockwise rotation matrices for x-axis (n=0), y-axis (n=1) and z-axis(n=2)
def Rth(n,theta):
    if n == 0:    
        R = np.array([[1.0, 0.0, 0.0],[0.0, np.cos(theta),np.sin(theta)],[0.0, -np.sin(theta), np.cos(theta)]])
    elif n == 1:
        R = np.array([[np.cos(theta), 0.0, -np.sin(theta)],[0.0, 1.0, 0.0],[np.sin(theta), 0.0, np.cos(theta)]])
    elif n == 2:
        R = np.array([[np.cos(theta), np.sin(theta), 0.0],[-np.sin(theta), np.cos(theta), 0.0],[0.0, 0.0, 1.0]])
    return R

# Compute partial solution f(Mn)(H) = R(Mn*t/In)*M
def fm_part(R,M):
    fmp = np.matmul(R,M)
    return fmp

# Compute Final solution fH for time t combining the partial solution fH(Mn).
# The outup of the exact solution for a partial step fH(Mn) is used as an initial condition for thw next partial step.
def fm_tot(n,M,I,dt):
    for i in chain(range(0,n),range(n-2,-1,-1)):
        # Determine the time t for the solutions fm
        if i != 2: 
            t = (dt/2)
        else:
            t = dt
        
        # Compute theta and clockwise rotation matrices
        th = (M[i]*t)/I[i]
        R = Rth(i,th)
        
        # Compute partial step fm for each H
        fmp = fm_part(R,M)
        
        # New initial conditions
        M = fmp
    w = [a/b for a,b in zip(M,I)]
    return w, M

#------------------------------------------------------------------------------------------------------------------------------
# Functions used in Tasks 1, 2 and 3

# This function calculates and plots the relative error in the energy log(|(E(t)-E(0))/(E(0))|) for both Task 2 and 3
def Error_calc(p,I,t_int,e_plotstr2):
    e = []
    E0 = ((I[0]*(p[0][0]**2) + I[1]*(p[0][1]**2) + I[2]*(p[0][2]**2))/2)
    
    for i in range(len(p)):
        if i == 0:
            continue
        E = ((I[0]*(p[i][0]**2) + I[1]*(p[i][1]**2) + I[2]*(p[i][2]**2))/2)
        e_part = math.log(abs((E-E0)/E0))
        e.append(e_part)
    plt.figure()
    plt.plot(t_int[1:],e)
    plt.title(f'Relative Error in the energy E(t) for {e_plotstr2[0]}\n{e_plotstr2[1]}')
    plt.xlabel('t')
    plt.ylabel('Relative Error')
    plt.grid()
    return

# Print the solutions w1(t), w2(t) and w3(t). This function is used in Tasks 1, 2 and 3.
def print_function(y,x,n,h,pstr):
    plt.figure()
    for i in range(n):
        yp = [row[i] for row in y]
        plt.plot(x,yp,label= r'$\omega_{%.d}(t)$' %(i+1))
    plt.title(f'{pstr[0]} of Euler\'s equation in t=[0,100]\n{pstr[1]}{h}')
    plt.xlabel('t')
    plt.ylabel(r'$\omega(t)$')
    plt.legend()
    plt.grid()
    return

#------------------------------------------------------------------------------------------------------------------------------
#Initialization

# Define sympolic variables
w1, w2, w3 = sp.symbols('w1, w2, w3')

# initial condition
I = np.array([0.8, 0.9, 1.0])
w = np.array([1.0, 0.0, 2.0])
M = [a*b for a,b in zip(I,w)]
n = len(w)
t_b = [0.0, 100.0]

# Three first order differential equations (Euler's equations)
wdot = [((I[1]-I[2])*w2*w3)/I[0], ((I[2]-I[0])*w3*w1)/I[1], ((I[0]-I[1])*w1*w2)/I[2]]

#------------------------------------------------------------------------------------------------------------------------------
# TASK1!!
# This section computes the analytical solutions for free rotation and draws the solutions.

# Strings used in plotting the the solutions w1(t), w2(t) and w3(t) 
plotstr1 = ['Analytical solutions','Using the jacobi elliptic functions']
h1 = ''

# X-axis values, time values
t_int = np.linspace(t_b[0],t_b[1],1000)

# Solutions calculated in terms of the Jacobi elliptic functions
w_jacobi, n, E2 = Jacobi(w,I)

# Draw solutions
print_function(w_jacobi,t_int,n,h1,plotstr1)

# Computation of the relative error in the energy log(|(E(t)-E(0))/(E(0))|)
Error_calc_Jacobi(w_jacobi,E2,t_int)

# As expected from the jacobi elliptic functions, the solutions are periodic. Furthermore, the energy is conserved however due 
# to computational calculations error is expected. Hence, the relative error in the energy log(|(E(t)-E(0))/(E(0))|) is
# calculated. From the plot of relative errors it is evident that the relative error in the energy is the machine precision
# e^(-36) = 10^(-16), approximately.
#------------------------------------------------------------------------------------------------------------------------------
# TASK2!!
# This section computes the solutions of Euler's equations via numerical integration of the first order differential equations.
# The moethod used is the Runge-Kutta 4th order.

# Strings used in plotting the the solutions w1(t), w2(t) and w3(t) 
plotstr2 = ['Numerical Solution','Runge Kutta 4th order method h=']
error_plotstr2 = ['the numerical solutions','Using the RK4 (Runge Kutta 4th order)']

# Define time t for axis x
# x values of time
h2 = 0.1
t_a = np.linspace(t_b[0],t_b[1],int((t_b[1]-t_b[0])/h2)+1)

# Implementation of RK4 
y_a = Runge_Kutta(wdot,h2,t_a,I,w)

# Draw solutions
print_function(y_a,t_a,n,h2,plotstr2)

# Computation of the relative error in the energy log(|(E(t)-E(0))/(E(0))|)
Error_calc(y_a,I,t_a,error_plotstr2)

# Comparing the numerical with the analytical solutions we can notice that are identical hence the implementation of the RK4 is
# successful. In addition to plotting the relative error in the energy log(|(E(t)-E(0))/(E(0))|) we observe that the relative 
# error is increased in contrast to the analytical solutions. This is expected because the analytical solutions computes the
# exact solutions hence they are prone only to machine precision, while via numerical integration truncation and round-off
# errors are introduced in the calculations. The relative error using RK4 is peropdic and gradually increases until
# it reaches a critical value which the relative error in the energy does not exceeds. The period of the relative error in the
# energy log(|(E(t)-E(0))/(E(0))|) is t=10. Every 10 units of time the absolute value of the solutions are approximetly equal
# hence the relative error in the energy has approximately the same values creating the period shown in the plot. When the
# values of w1, w2 and w3 are increasing the relative error of energy is increasing however when they are decreasing the
# relative error of energy is decreasing too.
#------------------------------------------------------------------------------------------------------------------------------
# Task3!!
# This section computes the solutions of Euler's equations using a splitting method.

# Strings used in plotting the the solutions w1(t), w2(t) and w3(t) 
plotstr3 = ['Splitting Method Solution','Splitting method\'s time step dt=']
error_plotstr3 = ['the splitting method solutions','']

# Define time t for axis x
# x values of time
h3 = 0.02
t = np.linspace(t_b[0],t_b[1],int((t_b[1]-t_b[0])/h3)+1)

# Splitting method
points = Splitting(t,w,M,I,h3)

# Print the solutions of differential equations
print_function(points,t,n,h3,plotstr3)

# Computation of the relative error in the energy log(|(E(t)-E(0))/(E(0))|)
Error_calc(points,I,t,error_plotstr3)

# Comparing the solutions of splitting method with the analytical solutions we can notice that are identical hence the
# implementation of the of the splitting method is successful. In addition to plotting the relative error in the energy
# log(|(E(t)-E(0))/(E(0))|) we observe that the relative error is increased in contrast to the analytical solutions and the
# numerical integration. This is expected because the analytical solutions computes the exact solutions hence they are prone only
# to machine precision, while via numerical integration and the splitting method truncation and round-off errors are introduced
# in the calculations. The relative error using the splitting methid is, too, peropdic. The period of the relative error in the
# energy log(|(E(t)-E(0))/(E(0))|) is t=10. Every 10 units of time the absolute value of the solutions are aproximetly equal.
# When the values of w1, w2 and w3 are increasing the relative error of energy increases however when they are decreasing the
# relative error of energy decreases too.

# Noticable is that the period of the relative error in the energy is the same for both RK4 and splitting method. The period is
# equal to T/4, where T is the period of solutions w1, w2 and w3. Each time the computed value of w1, w2 and w3 are equal to
# initial conditions the relative error in the energy is small while when the have their biggest absolute value the error is 
# greater. 

# It is already stated that the analytical solutions has the smallest possible relative error in energy, which is machine
# precision. Between the other two methods (RK4 and splitting method) the greatest reletive error is encoutered with the
# splitting method.