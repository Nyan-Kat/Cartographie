# -*- coding: utf-8 -*-
"""
Created on Thu Jun  1 19:03:51 2017

@author: lorrisbougon
"""

# Fonction pour ajouter une pièce après l'avoir détectée

cycle=[[0, 1, 2], [2, 5, 4], [0, 3, 2], [2, 4, 3]]
room=[[0,[0, 1, 2]],[1,[2, 5, 4]],[2,[0, 3, 2]]]

def main():
    global cycle
    global room
    newRoom=room
    for x in isNotIn():
        newRoom.append([len(newRoom),x])
    return newRoom

def isNotIn():
    t=[]
    for x in cycle:
        T=1
        for i in range(len(room)):
            if x == room[i][1]:
                T=0
        if T==1:
           t.append(x)
    return(t)