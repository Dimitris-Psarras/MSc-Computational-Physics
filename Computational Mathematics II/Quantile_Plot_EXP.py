# -*- coding: utf-8 -*-
"""
Created on Thu May 19 15:36:20 2022

@author: dipsa
"""

import numpy as np
import statsmodels.api as sm
import pylab as py
import scipy.stats as stats

rng = np.random.default_rng(seed=447)
#num = rng.standard_normal(100)
num = rng.random(100)
lamda = 0.5
y = -np.log(1-num)/lamda

sm.qqplot(num, line ='45',fit=True,dist=stats.uniform)
py.grid()
sm.qqplot(y, line ='45',fit=True,dist=stats.expon)
py.grid()
sm.qqplot(y, line ='45',fit=True,dist=stats.norm)
py.grid()
sm.qqplot(y, line ='45',fit=True,dist=stats.uniform)
py.grid()
py.show()