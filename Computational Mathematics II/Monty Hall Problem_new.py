import numpy as np

def doors(rng,n):
    dr = np.zeros((3,n))
    pos1 = rng.integers(0,3,(1,n))
    dr[pos1,range(n)] = 1
    return dr,pos1
    
def pick(rng,n,s):
    if s != 'c':
        pos = rng.integers(0,3,(1,n))
    else:
        pos = np.zeros((1,n))
    return pos

def Monty_Hall_game(strat,games):
    rng = np.random.default_rng()
    win = 0
    choices = 3
    doors_all = np.tile(np.array([0,1,2]), (games, 1))
    
    open_d = np.zeros((1,games))
    [d, p1] = doors(rng,games)
    p = pick(rng,games,strat)
    mask = np.ones((games,choices), dtype=bool)
    mask[range(games), p.astype(int)] = False
    doors_remaining = doors_all[mask].reshape(games, choices-1)
    
    choice = np.take_along_axis(doors_remaining,rng.integers(0,2,(games,1)),axis=1).reshape(games)
    
    index = p == p1
    open_d = np.where(index == True,choice,open_d)
    open_d = np.where(index == False,3-p1-p,open_d)
    
    if strat == 'a':
        win = np.sum(index)
        return (win/games)*100
    elif strat == 'b':
        final_p = 3 - p - open_d
        index = final_p == p1
        win = np.sum(index)
        return (win/games)*100
    elif strat == 'c':
        index = np.where(open_d == 2,np.invert(index),index)
        win = np.sum(index)
        return (win/games)*100

print("Welcome to Monty Hall Game!!")
print("Available Strategies:\n a) Stick with initial guess\n b) Always change from the initial guess\n c) First guess door 1, if Hall opens door 2 then dont change, if Hall opens door 3 then change door")
strategy = input("Please select the desired strategy for the Monty Hall Game: ")

number_of_games = 1000000
prob = Monty_Hall_game(strategy,number_of_games)

print(f"\nAfter {number_of_games} Monty Hall Games and for selected strategy {strategy} the win percentage is {prob}%.")