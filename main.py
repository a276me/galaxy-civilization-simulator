import readcsv
import random
import pygame
from core.star import Star
from core.Civilization import *
from pygame.locals import *
from core.misc import *
import core.main as core


#q, w = readcsv.getpoints()
#P = [[q[i],w[i]] for i in range(len(q))]
#STARS = []
#CIVS = [Civilization('neutral',0), Civilization('test',25)]
#CIVS[0].color = (255,255,255)
#for i in range(2000):
#    p = random.choice(P)
#    STARS.append(Star(p[0], p[1]))
 
core.setup()

# initialize pygame
pygame.init()
 
# Define the dimensions of screen object
screen = pygame.display.set_mode((950, 650))
 
# Variable to keep our game loop running
gameOn = True

clock = pygame.time.Clock()
clock.tick(30)

avrg = []
 
# Our game loop
while gameOn:
    # for loop through the event queue
    for event in pygame.event.get():
         
        # Check for KEYDOWN event
        if event.type == KEYDOWN:
             
            # If the Backspace key has been pressed set
            # running to false to exit the main loop
            if event.key == K_BACKSPACE:
                gameOn = False
                 
        # Check for QUIT event
        elif event.type == QUIT:
            gameOn = False
            
#    for c in range(1, len(CIVS), 1):
#        newsys = []
#        for k in range(int(len(CIVS[c].systems)/200.0)+2):
#            if len(CIVS[c].tmp) > len(CIVS[c].systems)*0.8:
#                CIVS[c].tmp = []
#            i = random.choice(CIVS[c].systems)
#            while i in CIVS[c].tmp:
#                i = random.choice(CIVS[c].systems)
#            CIVS[c].tmp.append(i)
#
#            for j in range(len(STARS)):
#                if dist(STARS[i].POS, STARS[j].POS) < 10 and j not in CIVS[c].systems:
#                    newsys.append(j)
#                    print(len(CIVS[c].systems))
#
#
#        CIVS[c].systems += newsys
#        for i in newsys:
#            STARS[i].owner = CIVS[c].id
    core.move()
            
    for i in core.STARS:
        pygame.draw.circle(screen, core.CIVS[i.owner].color,[i.POS[0], i.POS[1]], 1, 0)
    
    pygame.draw.circle(screen,(255,255,255),[20, 20], 10, 0)
    
 
 
    # Update the display using flip
    pygame.display.flip()
