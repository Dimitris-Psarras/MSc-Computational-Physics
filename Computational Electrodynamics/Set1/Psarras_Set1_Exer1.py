import matplotlib.pyplot as plt
import numpy as np
import warnings

dpi = 300
plt.rcParams['figure.dpi']= dpi

warnings.filterwarnings("ignore")

#Numerical calculation of up/c as a function of Dx/l
num = np.array([[2],[4],[8]])

Dx_l = np.linspace(0.001,0.34,10000)
up_c = (2*np.pi*Dx_l)/(np.arccos((num*num)*(np.cos(np.pi*Dx_l*(2/num))-1)+1))

#up/c for value Dx/l=0.1
Dx_l_p = 0.1
up_c_p = (2*np.pi*Dx_l_p)/(np.arccos((num*num)*(np.cos(np.pi*Dx_l_p*(2/num))-1)+1))
print('\nFor value Dx/lambda = 0.1 the ratio up/c is equal to:')
print(f'(a) up/c={up_c_p[0][0]}, (b) up/c={up_c_p[1][0]}, (c) up/c={up_c_p[2][0]}')

#plot the graphs
plt.semilogx(Dx_l, up_c[0],label=r'$c\Delta t=\frac{\Delta x}{2}$')
plt.semilogx(Dx_l, up_c[1],label=r'$c\Delta t=\frac{\Delta x}{4}$')
plt.semilogx(Dx_l, up_c[2],label=r'$c\Delta t=\frac{\Delta x}{8}$')
plt.axvline(x=0.1)
plt.legend()
plt.xlabel(r'$\frac{\Delta x}{\lambda_{o}}$')
plt.ylabel(r'$\frac{v_{p}}{c}$')
plt.grid()
plt.show()