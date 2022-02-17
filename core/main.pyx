import readcsv
import random
import pygame
from core.star import Star
from core.Civilization import *
from pygame.locals import *
from core.misc import *


CIVS = []
STARS = []



def setup():
    global CIVS, STARS
    q, w = readcsv.getpoints()
    P = [[q[i],w[i]] for i in range(len(q))]
    CIVS = [Civilization('neutral',0), Civilization('test',25),Civilization('test',10)]
    CIVS[0].color = (255,255,255)

    cdef int i = 0
    for i in range(2000):
        p = random.choice(P)
        STARS.append(Star(p[0], p[1]))

cpdef int move():
    global CIVS
    cdef int k = 0
    cdef int j = 0
    cdef int i
    for c in range(1, len(CIVS), 1):
        newsys = []
        for k in range(CIVS[c].tech):
            # if len(CIVS[c].tmp) > len(CIVS[c].systems)*0.8:
            #     CIVS[c].tmp = []
            i = random.choice(CIVS[c].systems)
            # while i in CIVS[c].tmp:
            #     i = random.choice(CIVS[c].systems)
            
            nps = []
            
            for j in range(len(STARS)):
                if dist(STARS[i].POS, STARS[j].POS) < 10+CIVS[c].tech and j not in CIVS[c].systems:
                    nps.append(j)
                    # print(len(CIVS[c].systems))

            if len(nps) > 0: newsys.append(random.choice(nps))
                    
            
        CIVS[c].systems += newsys
        for i in newsys:
            STARS[i].owner = CIVS[c].id

        if random.randint(0,1000) < 5:
            CIVS[c].tech += 1
            print('tech increased')
        elif random.randint(0,1000) < 2:
            CIVS[c].tech -= 1
            print('tech decreased')

        # print(CIVS[c].tech)

    if random.randint(0,1000) < 5:
        print('civilization formed!')
        CIVS.append(Civilization('test', random.choice(CIVS[0].systems)))
    if random.randint(0,1000) < 20:
        print(len(CIVS[0].systems))
    return 1

