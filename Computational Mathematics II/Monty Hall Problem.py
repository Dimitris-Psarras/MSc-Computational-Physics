import random as rn
import numpy as np

def doors():
    dr = np.zeros(3)
    pos1 = rn.randint(0,2)
    dr[pos1] = 1
    return dr,pos1
    
def pick():
    n = rn.random()
    pos =2 
    if n<(1/3):
        pos = 0
    elif n<(2/3):
        pos = 1
    return pos

def Monty_Hall_game(strat,games):
    win = 0
    for i in range(games):
        pos = [0,1,2]
        [d, p1] = doors()
        if strat == 'c':
            p = 0
        else:
            p = pick()
        if p==p1:
            pos.remove(p)
            h = rn.choice(pos)
        else:
            h = 3 - p - p1
        if strat == 'a':
            win += d[p]
        elif strat == 'b':
            win += d[3 - h - p]
        elif strat =='c':
            if h == 1:
                win += d[p]
            elif h == 2:
                win += d[3 - h - p]
    return (win/games)*100

print("Welcome to Monty Hall Game!!")
print("Available Strategies:\n a) Stick with initial guess\n b) Always change from the initial guess\n c) First guess door 1, if Hall opens door 2 then dont change, if Hall opens door 3 then change door")
strategy = input("Please select the desired strategy for the Monty Hall Game: ")

number_of_games = 100
prob = Monty_Hall_game(strategy,number_of_games)

print(f"\nAfter {number_of_games} Monty Hall Games and for selected strategy {strategy} the win percentage is {prob}%.")