#Listing 6.6
# DecaySound.py spon taneous decay simulation
import vpython as vp
import random , winsound

lambda1 = 0.0133 # Decay constant
ns = [10., 100., 1000, 10000., 100000.]
tt = 1200

graph1 = vp.graph(title= "Spontaneous Decay of Radon-220 lambda=0.0133*0.07(DN(t)/DN(0))" , xtitle = "Time", ytitle = "log[N(t)]" , xmin=0 ,xmax=tt+10 , ymin=0 ,ymax=vp.log(ns[-1]+10)/vp.log(10))

for nn in ns:
    max_n = nn ; time_max = tt ; seed = 68111
    number = nloop = max_n # Initial value
    
    decayfunc = vp.gcurve( color = vp.color.green)
    decayfunc.plot( pos = ( 0 , vp.log(number)/vp.log(10) ) )
    for time in vp.arange( 0 , time_max + 1 ): # Time loop
        for atom in vp.arange ( 1 , number + 1 ): # Decay loop
            decay = random.random( )
            l = lambda1 + (0.07*(number/max_n))
            if ( decay < l ):
                nloop = nloop-1
                
                winsound.Beep( 600 , 100 ) # Sound beep
        number = nloop
        if number == 0:
            break
        decayfunc.plot( pos = ( time , vp.log(number)/vp.log(10) ) )
        vp.rate( 30 )
