import readcsv
import random
import pygame
import sys
import time
from core.star import Star
from core.Civilization import *
from pygame.locals import *
from core.misc import *
import core.main as core


white = pygame.Color(255, 255, 255)
red = pygame.Color(255, 0, 0)
#q, w = readcsv.getpoints()
#P = [[q[i],w[i]] for i in range(len(q))]
#STARS = []
#CIVS = [Civilization('neutral',0), Civilization('test',25)]
#CIVS[0].color = (255,255,255)
#for i in range(2000):
#    p = random.choice(P)
#    STARS.append(Star(p[0], p[1]))
#sysfont = pygame.font.get_default_font()

def out(x,y,text):
    sys.stdout.write("\x1b7\x1b[%d;%df%s\x1b8" % (x, y, text))
    sys.stdout.flush()

 
def getColor(t, rgb):
    # Prints the text_msg in the foreground color specified by fore_tuple with the background specified by back_tuple
    # text_msg is the text, fore_tuple is foreground color tuple (r,g,b), back_tuple is background tuple (r,g,b)
    rf,bf,gf = rgb
    rb,gb,bb = rgb
    msg = '{0}' + t
    mat = '\33[38;2;' + str(rf) + ';' + str(gf) + ';' + str(bf) + ';48;2;' + str(rb) + ';' +str(gb) + ';' + str(bb) + 'm'
    return msg .format(mat) + '\33[0m'

 
core.setup()

# initialize pygame
pygame.init()
 
# Define the dimensions of screen object
screen = pygame.display.set_mode((950, 650))
 
# Variable to keep our game loop running
gameOn = True

avrg = []
    
#    img = myfont.render(t, (255,255,255))
#    screen.blit(img, (x, y))
 
# Our game loop
while gameOn:
    # for loop through the event queue
    for event in pygame.event.get():
         
                 
        # Check for QUIT event
        if event.type == QUIT:
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
    
    leaderboard = [] 
    for i in core.CIVS[1:]:
        if len(i.systems) >0:
            leaderboard.append(i)


    
    leaderboard.sort()
    leaderboard.reverse()
    
    j = 0
    for i in leaderboard:
        if len(i.systems) ==0:
            continue
        pygame.draw.circle(screen,i.color,[700, 50+30*j], 10, 0)
        j+=1

    
    j = 0
    for i in leaderboard:
        if len(i.systems) ==0:
           continue

        out(5+j*2, 0, ' '*100)
        out(5+j*2, 0, i.name)
        out(5+j*2, 40, str(i.tech))
        out(5+j*2, 44, str(len(i.systems)))
        out(5+j*2, 50, i.state)
        out(5+j*2, 60, str(getColor(' '*4, i.color)))

        
        j+=1
    
    j = 0
    for i in core.MSG[-5:]:
        out(5+j*2, 0, ' '*100)
        out(60+j*2, 0, i)
        j+=1
 
    # Update the display using flip
    pygame.display.flip()
