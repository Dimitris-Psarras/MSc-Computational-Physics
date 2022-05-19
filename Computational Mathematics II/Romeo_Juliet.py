import matplotlib.pyplot as plt
import numpy as np


table = [100, 1000, 10000, 100000, 1000000, 10000000]
mean_list = np.zeros(6)

for ind, i in enumerate(table):
    rng = np.random.default_rng(seed=3518)
    romeo = rng.integers(0,60,(i,1))
    juliet = rng.integers(0,60,(i,1))
    diff = np.absolute(romeo-juliet)
    success = (diff < 15).sum()
    mean_list[ind] = success/i

table = np.log(table)

plt.figure()
plt.plot(table,mean_list)
plt.scatter(table,mean_list)
plt.grid()
plt.show()