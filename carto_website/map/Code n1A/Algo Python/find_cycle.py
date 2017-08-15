# -*- coding: utf-8 -*-
"""
Created on Sun May 28 14:50:31 2017

@author: lorrisbougon
"""

# Fonction pour détecter la présence de cycle
# On peut la garder pour la lancer avant une recherche de tous les sommets des cycles : 
# cela permet de lancer une fonction moins lourde au cas ou il n'y aurait pas de cycle

L0 = [0,1,1,1,0,0]
L1 = [1,0,1,0,0,0]
L2 = [1,1,1,1,1,1]
L3 = [1,0,1,0,1,0]
L4 = [0,0,1,1,0,1]
L5 = [0,0,1,0,1,0]

matrix=[L0,L1,L2,L3,L4,L5]

# Parcours en profondeur : si pour le sommet current un de ses voisins a déjà été vu
# (ie dans p), cela veut dire qu'il existe un autre chemin pour y accéder et donc
# qu'il existe un cycle

def main():
    global matrix
    p=[0]                                       # pièces en cours
    seen=[]                                     # pièces vues
    number_cycle=0                              # compteur du nombre de cycles
    while len(p)!=0:
        current=p.pop()
        seen.append(current)
        n=next_door(matrix,current)
        while len(n)!=0:
            h=n.pop()
            if h in p:
                number_cycle+=1
            if h not in seen and h not in p :
                p.append(h)
    return(number_cycle)


def next_door(matrix,d):                        # fonction permettant d'avoir la liste des voisins d'un sommet
    l=[]
    for i in range(len(matrix)):
        if matrix[d][i]==1:
            l.append(i)
    return l