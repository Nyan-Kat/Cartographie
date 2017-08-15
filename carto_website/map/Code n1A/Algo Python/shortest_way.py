# -*- coding: utf-8 -*-
"""
Created on Fri May 26 18:10:19 2017

@author: lorrisbougon
"""

# Fonction permettant de connaître le plus court chemin entre 2 portes à partir
# des poids des chemins

L0 = [0,3,1,-1,-1,-1]
L1 = [3,0,1,3,-1,-1]
L2 = [1,1,0,3,4,-1]
L3 = [-1,3,3,0,1,3]
L4 = [-1,-1,4,1,0,1]
L5 = [-1,-1,-1,3,1,0]

matrix=[L0,L1,L2,L3,L4,L5]


def main(room1,room2):
    global matrix
    S=dijkstra(matrix,room1)
    return [S[room2][0]+[room2],S[room2][1]]

def linked(T,matrix):       # Pour lister tous les sommets non déjà vus et connecté
    l=[]                    # utilisée dans la fonction dijkstra
    for i in T:
        for u in range(len(matrix)):
            if u not in l and u not in T and matrix[i][u]>0 :
                l.append(u)
    return(l)

def shortest(l):            # pour trouver le chemin le plus court avec le numéro du sommet
    w=l[0][2]               # et le poids du chemin
    r=l[0][1]
    p=l[0][0]
    for i in range(1,len(l)):
        if l[i][2]<w:
            w=l[i][2]
            r=l[i][1]
            p=l[i][0]
    return [p,r]

def dijkstra(matrix,room):  # algo permettant de déterminer tous lee chemine lee plus court
    S=[[[],0] for i in range(len(matrix))]      # pour accéder à tous les
    seen=[room]
    while len(seen)!=len(matrix):
        W=linked(seen,matrix)
        way=[]
        for w in W:
            for s in seen:
                if matrix[w][s]>0 :
                    way.append([s,w,S[s][1]+matrix[w][s]])
        n=shortest(way)[1]
        p=shortest(way)[0]
        seen.append(n)
        S[n][0]=S[p][0]+[p]
        S[n][1]=S[p][1]+matrix[p][n]
    return S