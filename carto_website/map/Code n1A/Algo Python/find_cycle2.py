# -*- coding: utf-8 -*-
"""
Created on Thu Jun  1 15:43:56 2017

@author: lorrisbougon
"""

# Fonction permettant de déterminer tous les sommets des cycles SIMPLES

L0 = [0,1,1,1,0,0]
L1 = [1,0,1,0,0,0]
L2 = [1,1,1,1,1,1]
L3 = [1,0,1,0,1,0]
L4 = [0,0,1,1,0,1]
L5 = [0,0,1,0,1,0]

matrix=[L0,L1,L2,L3,L4,L5]
            
def turnIntoList(matrix):                   # fonction permettant de transformer en liste
    graph = []                              # de liste la matrice (l'algo est plus simple à coder
    k=0                                     # avec des listes de listes
    for i in range(len(matrix)):
        for j in range(k):
            if matrix[i][j]==1:
                graph.append([i,j])
        k+=1
    return graph

graph = turnIntoList(matrix)
cycles = []

# La fonction find_all_cycles détermine tous les cycles présents
# La fonction main à l'aide de la fonction quickSort élimine tous les cycles qui ne sont pas simples

def main():
    cycle=find_all_cycles()
    cycleSorted=quickSort(cycle)
    p=[]
    v=0                             # Variable servant à diminuer la longueur du cycle lors de la phase de suppression des cycles non simples
    for i in range (len(cycleSorted)-1):    # On parcourt tous les cycles
        for j in range(i+1,len(cycleSorted)):   # On les compare avec les cycles plus grands pour savoir s'ils sont contenus dedans
            t=[]                            # Liste permettant de stocker si oui ou non un sommet appartient à l'autre cycle
            for k in range(len(cycleSorted[i])):
                if cycleSorted[i][k] in cycleSorted[j]:
                    t.append(1)
                else:
                    t.append(0)
            if 0 not in t:                  # Si tous les sommets appartiennent à l'autre cycle, il est inclus dedans
                p.append(j)         # Si le cycle est contenu dans un plus grand, on ajoute le plus grand à p
    for u in (list(set(p))):        # Sans v, les index ne serait plus cohérents après une première suppression
        cycleSorted.pop(u-v)
        v+=1
    return cycleSorted

def find_all_cycles():
    global graph
    global cycles
    room=[]
    for edge in graph:
        for node in edge:
            findNewCycles([node])
    for cy in cycles:
        path = [node for node in cy]
        room.append(path)
    return room

def findNewCycles(path):
    start_node = path[0]
    next_node= None
    sub = []

    # On visite chaque arête et chaque sommet d'arête
    for edge in graph:
        node1, node2 = edge
        if start_node in edge:
                if node1 == start_node:
                    next_node = node2
                else:
                    next_node = node1
        if not visited(next_node, path):    # la porte voisine n'est pas encore dans le chemin
                sub = [next_node]
                sub.extend(path)            # on explore le chemin complété
                findNewCycles(sub);
        elif len(path) > 2  and next_node == path[-1]:  # cycle trouvé
                p = rotate_to_smallest(path);
                inv = invert(p)
                if isNew(p) and isNew(inv):
                    cycles.append(p)

def invert(path):
    return rotate_to_smallest(path[::-1])

def rotate_to_smallest(path):
    n = path.index(min(path))
    return path[n:]+path[:n]

def isNew(path):
    return not path in cycles

def visited(node, path):
    return node in path

def quickSort(x):                           # Algo de tri rapide visant à trier
    if len(x) == 1 or len(x) == 0:          # les chemins selon leur longueur
        return x
    else:
        pivot = len(x[0])
        i = 0
        for j in range(len(x)-1):
            if len(x[j+1]) < pivot:
                x[j+1],x[i+1] = x[i+1], x[j+1]
                i += 1
        x[0],x[i] = x[i],x[0]
        first_part = quickSort(x[:i])
        second_part = quickSort(x[i+1:])
        first_part.append(x[i])
        return first_part + second_part