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
    CIVS = [Civilization('neutral',0), Civilization('test',25)]
    CIVS[0].color = (255,255,255)

    cdef i = 0
    for i in range(2000):
        p = random.choice(P)
        STARS.append(Star(p[0], p[1]))

def move():
    cdef k = 0
    cdef j = 0
    for c in range(1, len(CIVS), 1):
        newsys = []
        for k in range(CIVS[c].tech):
            if len(CIVS[c].tmp) > len(CIVS[c].systems)*0.8:
                CIVS[c].tmp = []
            i = random.choice(CIVS[c].systems)
            while i in CIVS[c].tmp:
                i = random.choice(CIVS[c].systems)
            CIVS[c].tmp.append(i)
            
            
            for j in range(len(STARS)):
                if dist(STARS[i].POS, STARS[j].POS) < 10 and j not in CIVS[c].systems:
                    newsys.append(j)
                    print(len(CIVS[c].systems))
                    
            
        CIVS[c].systems += newsys
        for i in newsys:
            STARS[i].owner = CIVS[c].id
            
