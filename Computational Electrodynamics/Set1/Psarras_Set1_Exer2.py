import matplotlib.pyplot as plt
import numpy as np

# High resolution graphs
dpi = 300
plt.rcParams['figure.dpi']= dpi

# Initial Conditions for grid coordinates for time n = -1 and 0
def Initial_Condition_Grid(size,l,u):
    grid = np.zeros((2,size))
    grid[0][l:u] = 1
    grid[0][l+5:u+5] = -1
    grid[1][l+1:u+1] = 1
    grid[1][l+6:u+6] = -1
    return grid


def solveFTDT_1D(size,u,dx,a,c,fs):
    # Solve FTDT. Input is the grid of coordinates i for times n = -1 and 0
    # The function returns nothing but it plots the frames that were given as input
    u_next = np.zeros(size)
    dt = a*(dx/c)
    x = np.arange(0,size*dx,0.1)
    
    # u_frames is an array with array elements. Its array element is the solution u for the corresponding time frame
    frames = len(fs)
    u_frames = [0]*frames   
    index = 0
    
    # Initialize the plot combining all the time frames
    plt.figure()
    
    # its loop in the for represents the time frame for which u is calculated
    for i in range(1,101):
        # u_next is the solution u in the corresponding time frame and it is computed in the following command
        u_next = pow(c*dt,2)*((np.array((u.tolist()[1][1:]+[u.tolist()[1][0]]))-2*(u[1][:])+np.array(([u.tolist()[1][-1]]+u.tolist()[1][:-1])))/(dx**2))+2*u[1][:]-u[0][:]
        
        # Boundary conditions
        u_next[0] = 0
        u_next[-1] = 0
        
        # the u array receives the required grid of u to calculate the next frame
        u[0][:] = u[1][:]
        u[1][:] = u_next
        
        # for the time frames is fs list the combining plot is constructed and the u_frames saves the u solution for there time frames
        if i in fs:
            u_frames[index] = u_next
            index += 1
            plt.plot(x,u_next,label=f'$u^{{{i}}}$')
            plt.grid()
            
    # Combination of plots plot
    plt.title(f"Combination of plots for $\Delta t={a}\Delta x/c$")
    plt.ylabel(r"$u_{i}$")
    plt.xlabel(r"Grid Coordinates i")
    plt.legend()
    plt.show()
    
    # Print the time frames individually
    print_individual_plots(x,u_frames,i)
    return 

# Subplot of individual frames
def print_individual_plots(x,u,i):
    fig, axes = plt.subplots(2, 3)
    plt.grid()
    axes[0, 0].plot(x, u[0],label=r'$u^{20}$')
    axes[0, 0].grid()
    axes[0, 0].legend()
    axes[0, 1].plot(x, u[1], 'tab:orange',label=r'$u^{40}$')
    axes[0, 1].grid()
    axes[0, 1].legend()
    axes[0, 2].plot(x, u[2],'tab:green',label=r'$u^{60}$' )
    axes[0, 2].grid()
    axes[0, 2].legend()
    axes[1, 0].plot(x, u[3], 'tab:red',label=r'$u^{80}$')
    axes[1, 0].grid()
    axes[1, 0].legend()
    axes[1, 1].plot(x, u[4], 'tab:purple',label=r'$u^{100}$')
    axes[1, 1].grid()
    axes[1, 1].legend()
    axes[1, 2].set_visible(False)
    
    for ax in axes.flat:
        ax.set(xlabel=r'Grid Coordinates i', ylabel=r'$u_{i}$')
    
    # Hide x labels and tick labels for top plots and y ticks for right plots.
    for ax in axes.flat:
        ax.label_outer()
    return 


# Main Code

# Initialization of constants for all the cases
size = 120
c=1
init_l = 1
init_u = 5
frames = [20, 40, 60, 80, 100]

# Case 1: Dt = 0.9 Dx/c

# Parameters of case 1
dx = 0.1
a = 0.9

# Execution of functions for the 1D FTDT
u_init = Initial_Condition_Grid(size,init_l,init_u)
solveFTDT_1D(size,u_init,dx,a,c,frames)

# Title for the subplot
plt.suptitle(f"Case 1: $\Delta t={a}\Delta x/c$")
plt.show()

# Case 2: Dt = 1.0 Dx/c

# Parameters of case 2
dx = 0.1
a = 1.0

# Execution of functions for the 1D FTDT
u_init = Initial_Condition_Grid(size,init_l,init_u)
solveFTDT_1D(size,u_init,dx,a,c,frames)

# Title for the subplot
plt.suptitle(f"Case 2: $\Delta t={a}\Delta x/c$")
plt.show()

# Case 3: Dt = 1.1 Dx/c

# Parameters of case 3
dx = 0.1
a = 1.1

# Execution of functions for the 1D FTDT
u_init = Initial_Condition_Grid(size,init_l,init_u)
solveFTDT_1D(size,u_init,dx,a,c,frames)

# Title for the subplot
plt.suptitle(f"Case 3: $\Delta t={a}\Delta x/c$")
plt.show()