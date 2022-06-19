# Entangle.py : Calculate quantum entangled states
import numpy as np ; import numpy.linalg as lin

np.set_printoptions(suppress=True)

nmax = 4
H = np.zeros((nmax,nmax),float)

phi0 = np.array([[1],[0]])
phi1 = np.array([[0],[1]])
phi00 = np.kron(phi0,phi0)
phi10 = np.kron(phi1,phi0)
phi01 = np.kron(phi0,phi1)
phi11 = np.kron(phi1,phi1)
print(f"\n|00> equals to \n{phi00} \n" )
print(f"\n|10> equals to \n{phi10} \n" )
print(f"\n|01> equals to \n{phi01} \n" )
print(f"\n|11> equals to \n{phi11} \n" )

X = np.array([[0,1],[1,0]])
Y = np.array([[0,-1j],[1j,0]])
Z = np.array([[1,0],[0,-1]])
XAXB = np.kron(X,X)
YAYB = np.real(np.kron(Y,Y))
ZAZB = np.kron(Z,Z)
print(f"\nThe tensor product of XA and XB is \n{XAXB} \n" )
print(f"\nThe tensor product of YA and YB is \n{YAYB} \n" )
print(f"\nThe tensor product of ZA and ZB is \n{ZAZB} \n" )

SASB = XAXB + YAYB + ZAZB - 3*ZAZB # Hamiltonian

print(f"\nHamiltonian without mu^2/r^3 factor \n{SASB} \n" )

es , ev = lin.eig(SASB) # Eigenvalues and eigenvectors

print(f"Eigenvalues\n{es}\n")
print(f"Eigenvectors (in columns)\n{ev}\n" )

phi1 = (ev[0,0],ev[1,0],ev[2,0],ev[3,0]) # Eigenvectors
phi2 = (ev[0,3],ev[1,3],ev[2,3],ev[3,3])
phi3 = (ev[0,2],ev[1,2],ev[2,2],ev[3,2])
phi4 = (ev[0,1],ev[1,1],ev[2,1],ev[3,1])

basis = [phi1 , phi2 , phi3 , phi4 ] # Listeigenvectors

for i in range ( 0 ,nmax) : # Hamiltonian in new basis
    for j in range ( 0 ,nmax) :
        term = np.dot(SASB, basis[ i ] )
        H[i,j] = np.dot(basis[j], term)

print (f"Hamiltonian in Eigenvector Basis \n{H}" )