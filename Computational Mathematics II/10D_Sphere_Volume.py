import numpy as np
import numpy.linalg as lin

def nSphereVolume(dim,iterations,side):
    V = pow(side,dim)
    rng = np.random.default_rng(seed = 4407)
    mc = rng.uniform(-side/2,side/2,(int(iterations),dim))
    r = lin.norm(mc,axis=1)
    f = np.sum(r<=side/2)
    I = (V/iterations)*f
    return I

print(f'The volume of a 10D sphere is: {nSphereVolume(3,10e6,2)}')

