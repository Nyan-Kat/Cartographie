# -*- coding: utf-8 -*-
"""
Created on Thu Jun  1 18:49:02 2017

@author: lorrisbougon
"""

# Fonction pour ajouter une porte au graphe de liaison pondéré ou graphe de construction des pièces

def add_matrix(matrix,n):
    m=matrix
    for j in range(n):
        for i in range(len(matrix)):
            m[i].append(0)
        m.append([0 for i in range(len(matrix)+1)])
    return m