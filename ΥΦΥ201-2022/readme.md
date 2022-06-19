# ΥΦΥ201-2022 Project

## Directory Structure
In this directory readers can find the following folders:
1. __Listings__, which includes the two python codes
2. __Figures__, which includes the printed figures from the execution of the python code
3. __Presentation__, which includes the presentation prepared for the project

## Project overview
As part of the compulsory elective course Computational Quantum Physics and Applications (7.5 ECTS credits) students were tasked to choose two problems of Chapter 6 from the book Computational Problems for Physics (with guided solutions using Python) and replicate the according listings and perform the necessary changes on them in order to solve the problems. The final codes developed from the student were presented on the final day of the class.

## Files Discription
Each folder inside this directory contains a number of files.
1. __Code__
    1. __DecaySound.py__ is the python programme (based on the Listing 6.6) created to simulate spontaneous decay. The code also creates a sound each time a particle decays and plots the results. 
    The simulation was executed for:
        1. Radon-206 with decay constant $\lambda = 0.002533s^{−1}$
        2. Radon-220 with decay constant $\lambda = 0.0133s^{-1}$
        3. Radon-206 including the effect of stimulated emission with parameter a = 0.01
        4. Radon-220 including the effect of stimulated emission with parameter a = 0.07
    2. __Listing22.py__ is the python programme (based on the Listing 6.22) created to compute the following:
        1. Compute the qubits as the direct products from a basis of $\mathbb{C}^4$
        2. Evaluate the tensor products $XA\otimes XB$, $YA\otimes YB$ and $ZA\otimes ZB$ as 4×4 matrices.
        3. Evaluate the Hamiltonian in the direct product space.
        4. Evaluate the eigenvalues of H and the corresponding eigenvectors.
        5. Using these eigenvectors states as new basis states, express the Hamiltonian matrix H in these basis states.
2. __Figures__, which includes the printed figures from the execution of the python code
    1. __DecaySoundRadon206.png__, this semilog plot show results of five simulations for Radon 206, all with the same decay constant, but differing initial numbers of atoms.
    2. __DecaySoundRadon206Em.png__, this semilog plot show results of five simulations for Radon 206, all with the same decay constant including the effect of stimulated emission with parameter a = 0.01, but differing initial numbers of atoms.
    3. __DecaySoundRadon220.png__, this semilog plot show results of five simulations for Radon 220, all with the same decay constant, but differing initial numbers of atoms.
    4. __DecaySoundRadon220Em.png__, this semilog plot show results of five simulations for Radon 220, all with the same decay constant including the effect of stimulated emission with parameter a = 0.07, but differing initial numbers of atoms.
3. __Presentation__, which includes the presentation prepared for the project
    1. __Comp_Quantum_Presentation_Psarras.pdf__ is the pdf file containing the presentation presented on the final day if the class.