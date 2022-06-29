import numpy as np
import matplotlib.pyplot as plt
import warnings
warnings.filterwarnings("ignore")

dpi = 300
plt.rcParams['figure.dpi']= dpi

def f(x):
    return 2/(np.pi*np.sqrt(1-x**2))

def g(x):
    return 1/(2*np.sqrt(1-x))

def Acceptance_Rejection(n):
    rng = np.random.default_rng(seed=4407)
    k = 4/np.pi
    X = np.zeros(n)
    for i in range(n):
        while True:
            y = 1-(1-rng.random())**2
            U = rng.uniform()
            
            if U <= (f(y))/(k*g(y)):
                X[i] = y
                break
    return X

V = Acceptance_Rejection(100000)

Dist = Acceptance_Rejection(100)
print('100 Numbers distributed according to the pdf function 2/(pi*sqrt(1-x**2))\n')
print(f'{Dist}')

plt.figure()
plt.title(r'Distribution of f(x)=$\frac{2}{\pi*\sqrt{1-x^2}}$')
plt.ylabel('y')
plt.xlabel('x')
plt.hist(V,bins=50,density=True,stacked=True)
xx = np.linspace(0,1,100000)
plt.plot(xx,f(xx))
plt.ylim(0,7)
plt.grid()