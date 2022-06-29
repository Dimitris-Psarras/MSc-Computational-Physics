import matplotlib.pyplot as plt
import numpy as np


table = [100, 1000, 10000, 100000, 1000000, 10000000]
mean_list = np.zeros(6)

rng = np.random.default_rng(seed=3518)
for ind, i in enumerate(table):
    romeo = rng.uniform(0,60,(i,1))
    juliet = rng.uniform(0,60,(i,1))
    diff = np.absolute(romeo-juliet)
    success = (diff <= 15).sum()
    mean_list[ind] = success/i

print(f'For {table[-1]} meeting the probability of romeo and juliet to meet is: {mean_list[-1]}')

table = np.log10(table)

plt.figure()
plt.plot(table,mean_list)
plt.scatter(table,mean_list)
plt.title('Probability Romeo and Juliet to meet')
plt.ylabel('Probability')
plt.xlabel('Meetings')
plt.grid()
plt.show()