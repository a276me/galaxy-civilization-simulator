import readcsv
import random
import pygame
from core.star import Star
from core.Civilization import *
from pygame.locals import *
from core.misc import *


CIVS = []
STARS = []

STOP = False

def setup():
    global CIVS, STARS
    q, w = readcsv.getpoints()
    P = [[q[i],w[i]] for i in range(len(q))]
    CIVS = [Civilization(generateName(),0), Civilization(generateName(),25),Civilization(generateName(),10)]
    CIVS[0].color = (255,255,255)

    cdef int i = 0
    for i in range(2000):
        p = random.choice(P)
        STARS.append(Star(p[0], p[1]))

cpdef move():
    global STOP

    global CIVS
    cdef int k = 0
    cdef int j = 0
    cdef int i = 0

    if(STOP):
        return
    for c in range(1, len(CIVS), 1):
        if len(CIVS[c].systems) == 0:
            if CIVS[c].color in used: 
                used.remove(CIVS[c].color)
                colors.append(CIVS[c].color)
            continue
        newsys = []
        for k in range(CIVS[c].tech):
            # if len(CIVS[c].tmp) > len(CIVS[c].systems)*0.8:
            #     CIVS[c].tmp = []
            i = random.choice(CIVS[c].systems)
            # while i in CIVS[c].tmp:
            #     i = random.choice(CIVS[c].systems)
            
            nps = []
            
            for j in range(len(STARS)):
                l = CIVS[c].tech
                if l > 20:
                    l = 20
                if dist(STARS[i].POS, STARS[j].POS) < 10+l and j not in CIVS[c].systems:
                    if(random.randint(0,CIVS[c].tech+CIVS[STARS[i].owner].tech) < CIVS[c].tech):
                        nps.append(j)
                    # print(len(CIVS[c].systems))

            if len(nps) > 0: newsys.append(random.choice(nps))
                    
            
        CIVS[c].systems += newsys
        for i in newsys:
            # print(len(CIVS[STARS[i].owner].systems))
            try:
                CIVS[STARS[i].owner].systems.remove(i)
                STARS[i].owner = CIVS[c].id
            except Exception:
                print(i, CIVS[c].name, CIVS[STARS[i].owner].name,CIVS[STARS[i].owner].systems) 
                STOP = True
            

        if random.randint(0,1000) < 5:
            CIVS[c].tech += 1
            if CIVS[c].tech > len(CIVS[c].systems):
                CIVS[c].tech -= 1
            # print('tech increased')
        elif random.randint(0,1000) < 3:
            CIVS[c].tech -= 1

        if CIVS[c].tech < 0:
            for i in range(abs(CIVS[c].tech)):
                s = random.choice(CIVS[c].systems)

                CIVS[c].systems.remove(s)
                CIVS[0].systems.append(s)
                STARS[s].owner = 0
        if CIVS[c].tech < 0 and 0 < len(CIVS[c].systems) < 2:
            a = CIVS[c].systems[0]
            CIVS[c].systems.remove(a)
            CIVS[0].systems.append(a)
            STARS[a].owner = 0
            

        # print(CIVS[c].tech)

    if random.randint(0,1000) < 5:
        # print('civilization formed!')
        n = 0
        for p in CIVS:
            if len(p.systems) > 0:
                n+=1
        if n < 11:
            CIVS.append(Civilization(generateName(), random.choice(CIVS[0].systems)))
    
    return 1

