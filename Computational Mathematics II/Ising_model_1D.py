import numpy as np
import matplotlib.pyplot as plt

dpi = 300
plt.rcParams['figure.dpi']= dpi

def energy_ising_1d(configuration,J,h):
    num_spins = len(configuration)
    energy = 0.0
    for i in range(num_spins):
        spin_i = configuration[i]
        ip1 = (i+1)%num_spins
        spinip1 = configuration[ip1]
        energy = energy - J * (spin_i * spinip1) - h*spin_i
    return energy

def initial_state(N):
    rng = np.random.default_rng()
    state = 2*rng.integers(0,2,N)-1
    return state

def energy_difference(J, h, si, sleft, sright):
    dE = 2*h*si + 2*J*si*(sleft+sright)
    return dE

def metropolis_mc_fast(n_steps, n_lattice_sites, beta, J, h):
    configuration = initial_state(n_lattice_sites)
    average_spins = np.zeros(n_steps)
    energies = np.zeros(n_steps)
    
    current_energy = energy_ising_1d(configuration,J,h)
    for i in range(n_steps):
        rng = np.random.default_rng()
        
        spin_to_change = rng.integers(n_lattice_sites)
        
        si = configuration[spin_to_change]
        
        sright = configuration[(spin_to_change+1)%n_lattice_sites]
        sleft = configuration[(spin_to_change-1)%n_lattice_sites]

        dE = energy_difference(J,h,si,sleft,sright)
        
        r = rng.uniform()
        
        if r<min(1,np.exp(-beta*(dE))) :
            
            configuration[spin_to_change]*=-1
            
            current_energy += dE
        else:
            pass
        
        #this computes the average spin
        average_spin = configuration.mean()
        
        
        average_spins[i] = average_spin
        energies[i] = current_energy
        
    return average_spins,energies
            
#do a test high temperature simulation

n_steps = 100000
n_lattice_sites = 10000
J = 1
h = 0

T = 20
beta = 1/T
average_spins, energy = metropolis_mc_fast(n_steps, n_lattice_sites, beta, J, h)
plt.figure()
plt.plot(average_spins)
plt.ylabel("$m$")
plt.xlabel("MC Step")
plt.title("$\\beta=%.2f,$J=%.2f,$h=%.2f$"%(beta,J,h))
plt.grid()
plt.figure()
plt.plot(energy)
plt.ylabel("$E$")
plt.xlabel("MC Step")
plt.title("$\\beta=%.2f,$J=%.2f,$h=%.2f$"%(beta,J,h))
plt.grid()

T = 10
beta = 1/T
average_spins, energy = metropolis_mc_fast(n_steps, n_lattice_sites, beta, J, h)
plt.figure()
plt.plot(average_spins)
plt.ylabel("$m$")
plt.xlabel("MC Step")
plt.title("$\\beta=%.2f,$J=%.2f,$h=%.2f$"%(beta,J,h))
plt.grid()
plt.figure()
plt.plot(energy)
plt.ylabel("$E$")
plt.xlabel("MC Step")
plt.title("$\\beta=%.2f,$J=%.2f,$h=%.2f$"%(beta,J,h))
plt.grid()

T = 1
beta = 1/T
average_spins, energy = metropolis_mc_fast(n_steps, n_lattice_sites, beta, J, h)
plt.figure()
plt.plot(average_spins)
plt.ylabel("$m$")
plt.xlabel("MC Step")
plt.title("$\\beta=%.2f,$J=%.2f,$h=%.2f$"%(beta,J,h))
plt.grid()
plt.figure()
plt.plot(energy)
plt.ylabel("$E$")
plt.xlabel("MC Step")
plt.title("$\\beta=%.2f,$J=%.2f,$h=%.2f$"%(beta,J,h))
plt.grid()