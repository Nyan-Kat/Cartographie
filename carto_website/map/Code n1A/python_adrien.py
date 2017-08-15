# -*- coding: utf-8 -*-
"""
@author: adriengicquel
"""

##importation
import psycopg2
import math
from decimal import *
from Tkinter import *
import numpy as np

##valeurs
limite_vision = 95
limite_dist = 10 #Distance pour considérer qu'on est toujours sur le même mur
limite_dist_2murs = 40
limite_porte_min = 70
limite_porte_max = 120
limite_angle = 0.99 #Valeur minimal du cos de l'angle (en valeur absolue) pour dire qu'il est assez faible

                                                      
def dist2point(cur,conn):
    cur.execute("SELECT * FROM Donnees_capteurs ORDER BY ID LIMIT 1")
    data = cur.fetchone()
    if data == None:
        return None
    cur.execute("DELETE FROM Donnees_capteurs WHERE ID = %s" %data[0])
    (pos_x,pos_y,pos_t) = data[2:5]
    distances = data[5:31]
    angle = -60
    getcontext().prec = 4
    for dist in distances:
        if dist < limite_vision:
            x = pos_x + dist * Decimal(math.cos(math.radians(pos_t + angle)))
            y = pos_y + dist * Decimal(math.sin(math.radians(pos_t + angle)))
            cur.execute("INSERT INTO Points_calcules(angle,coordonnee_x,coordonnee_y) VALUES (%s,%s,%s)", (angle, x, y))
            conn.commit()
        angle += 5
    return data[0]


def distance(a,b):
    return math.sqrt(math.pow(a[0]-b[0], 2) + math.pow(a[1]-b[1], 2))

def scalaire(a,b,c,d):
    return (b[0]-a[0]) * (d[0]-c[0]) + (b[1]-a[1]) * (d[1]-c[1])

def check_dist(a,b):
    if distance(a,b) < limite_dist:
        return True
    return False
    
def check_angle(a,b,c,d):
    if abs(float(scalaire(a,b,c,d))) / (float(distance(a,b)) * float(distance(c,d))) > limite_angle:
        return True
    return False

def insere_point(cur, conn, point):
    cur.execute("INSERT INTO Points(coordonnee_x,coordonnee_y) VALUES (%s,%s) RETURNING ID", point)
    conn.commit()
    return cur.fetchone()

def update_point(cur, conn, point, point_id):
    donnees = point[0],point[1],point_id
    cur.execute("UPDATE Points SET coordonnee_x = %s, coordonnee_y = %s WHERE ID = %s" %donnees)
    conn.commit()

def insere_mur(cur,conn,a,b,id_donnee):
    if not a == b:
        cur.execute("SELECT a.ID, ID_point1,a.coordonnee_x, a.coordonnee_y, ID_point2, b.coordonnee_x, b.coordonnee_y FROM ((SELECT Murs.ID,ID_donnee,ID_point1,coordonnee_x, coordonnee_y FROM Points JOIN Murs ON Points.ID = Murs.ID_point1) AS a JOIN (SELECT Murs.ID,ID_donnee,ID_point2,coordonnee_x, coordonnee_y FROM Points JOIN Murs ON Points.ID = Murs.ID_point2) AS b ON a.ID = b.ID)")
        murs_test = cur.fetchall()
        done = False
        for mur in murs_test:            
            if check_angle(a,b,mur[2:4],mur[5:7]):
                dist = [distance(a,mur[2:4]),distance(a,mur[5:7]),distance(b,mur[2:4]),distance(b,mur[5:7])]
                if min(dist) < limite_dist_2murs:
                    dist +=  [distance(a,b),distance(mur[2:4],mur[5:7])]
                    murs = [(a,mur[1]),(a,mur[4]),(b,mur[1]),(b,mur[4]),(a,b)]
                    index_nouveau_mur = np.argmax(dist) 
                    if index_nouveau_mur != 5:                        
                        nouveau_mur = murs[index_nouveau_mur]
                        if index_nouveau_mur == 4:
                            update_point(cur,conn,nouveau_mur[0],mur[1])
                            update_point(cur,conn,nouveau_mur[1],mur[4])
                        else:
                            if nouveau_mur[1] == mur[1]:
                                update_point(cur,conn,nouveau_mur[0],mur[4])
                            else:
                                update_point(cur,conn,nouveau_mur[0],mur[1])
                    done = True
                    break
        if not done:
            ids = id_donnee, insere_point(cur,conn,a)[0], insere_point(cur,conn,b)[0]
            cur.execute("INSERT INTO Murs(ID_donnee,ID_point1, ID_point2) VALUES (%s,%s,%s)", ids)
            conn.commit()
            cur.execute("SELECT ID_point1,a.coordonnee_x, a.coordonnee_y, ID_point2, b.coordonnee_x, b.coordonnee_y FROM ((SELECT Murs.ID,ID_donnee,ID_point1,coordonnee_x, coordonnee_y FROM Points JOIN Murs ON Points.ID = Murs.ID_point1) AS a JOIN (SELECT Murs.ID,ID_donnee,ID_point2,coordonnee_x, coordonnee_y FROM Points JOIN Murs ON Points.ID = Murs.ID_point2) AS b ON a.ID = b.ID)")
            murs = cur.fetchall()
            for mur in murs:
                dist = [distance(a,mur[1:3]),distance(a,mur[4:6]),distance(b,mur[1:3]),distance(b,mur[4:6])]                
                i = np.argmin(dist)
                if dist[i] > limite_porte_min:
                    portes = [(ids[1],mur[0]),(ids[1],mur[3]),(ids[2],mur[0]),(ids[2],mur[3])]
                    cur.execute("INSERT INTO Portes(ID_point1,Id_point2) VALUES (%s,%s)", portes[i])
                    conn.commit()
        refresh_portes(cur,conn)
        
            
def point2mur(cur,conn, id_donnee):
    cur.execute("SELECT coordonnee_x, coordonnee_y FROM Points_calcules ORDER BY angle")
    points = cur.fetchall()
    if len(points) > 0:
        point_debut, point_fin = points[0],points[0]
        for i in range(1,len(points)-1):
            if check_dist(point_fin, points[i]) and (point_debut == point_fin or check_angle(point_debut,point_fin, point_fin, points[i])):
                    point_fin = points[i]
            else:
                insere_mur(cur,conn,point_debut,point_fin,id_donnee)
                point_debut, point_fin = points[i], points[i]
        insere_mur(cur,conn,point_debut,point_fin,id_donnee)

def refresh_portes(cur,conn):
    cur.execute("SELECT Portes.ID, isLenghtGood, a.coordonnee_x, a.coordonnee_y, b.coordonnee_x, b.coordonnee_y FROM (Portes JOIN Points as a ON ID_point1 = a.ID) JOIN Points as b ON ID_point2 = b.ID")
    portes = cur.fetchall()
    for porte in portes:
        d = distance(porte[2:4],porte[4:6])
        if d < limite_porte_min:
            cur.execute("DELETE FROM Portes WHERE ID = %s" %porte[0])
            conn.commit()
        elif d < limite_porte_max and not porte[1]:
            cur.execute("UPDATE Portes SET isLenghtGood = True WHERE ID = %s" %porte[0])
            conn.commit()
        elif d > limite_porte_max and porte[1]:
            cur.execute("UPDATE Portes SET isLenghtGood = False WHERE ID = %s" %porte[0])
            conn.commit()

def find_closest(mur,murs):
    for i in range(len(murs)):
        print("test")
        
def mur2piece(cur,conn):
    cur.execute("SELECT Murs.ID, a.ID, a.coordonnee_x, a.coordonnee_y, b.ID, b.coordonnee_x, b.coordonnee_y, FROM (Murs JOIN Points as a ON ID_point1 = a.ID) JOIN Points as b ON ID_point2 = b.ID")
    murs = cur.fetchall()
    piece = []
    for mur in murs:
        print("test")
        
    
def analyse(cur, conn):
    id_donnee = dist2point(cur,conn) 
    while id_donnee != None:
        point2mur(cur,conn, id_donnee)
        cur.execute("TRUNCATE TABLE Points_calcules")
        conn.commit()
        id_donnee = dist2point(cur,conn)

