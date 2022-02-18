import random

CID = 0

class Civilization:
    def __init__(self,name,startSys):
        global CID
        self.name = name
        self.id = CID
        CID += 1
        self.color = (random.randint(10,255),random.randint(10,255), random.randint(10,255))
        self.tech = 1
        self.systems = []
        self.systems.append(startSys)
        self.tmp = []
        
        if self.id == 0:
            self.systems = []
            for i in range(2000):
                self.systems.append(i)
        
