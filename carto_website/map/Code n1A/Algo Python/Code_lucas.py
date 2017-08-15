##importation

import psycopg2
from math import sqrt
import collections

##valeurs

L1 = 0.9  # paramêtre de la grande maille
L2 = L1 / 3
L3 = L1 / 9

n = 10  # nombre de cases du grand maillage
m = 10

v = 10  # cm/s
t1 = L2 / v
t2 = 1, 4 * t1
time_rotate = 0.375  # temps de rotation pour un angle de pi/4


##Connexion à la base de données

def connexion():
    try:
        conn = psycopg2.connect("dbname='Projet' user='postgres' host='localhost' password='Superman1'")
        return (conn)
    except:
        print ("échec de la connexion")


##Création des tables 
def create_tables():
    Commandes = [
        # création de la table correspondant au maillage grossier
        """create table maillage1 (
        X1 smallint,
        Y1 smallint,
        Occupied smallint,
        Discovered smallint,
        primary key (X1,Y1));"""
        ,
        # création de la table correspondant au maillage intermédiaire
        """create table maillage2 (
        X1 smallint,
        Y1 smallint,	
        X2 smallint,
        Y2 smallint,
        Occupied smallint,
        Discovered smallint,
        Wall smallint,
        Door smallint,
        primary key (X1,Y1, X2, Y2),
        foreign key (X1,Y1) references maillage1);"""

        ,
        # création de la table correspondant au maillage fin
        """create table maillage3 (
        X1 smallint,
        Y1 smallint,
        X2 smallint,
        Y2 smallint,
        X3 smallint,
        Y3 smallint,
        Occupied smallint,
        Discovered smallint,
        primary key (X1,Y1, X2, Y2, X3,Y3),
        foreign key (X1, Y1, X2,Y2) references maillage2);"""
        ,
        # création de la table Portes
        """create table Portes (
        ID_porte serial primary key,
        Coordinate_X real,
        Coordinate_Y real,
        Width real,
        Orientation real);"""
        ,
        # création de la table Trajets
        """create table Trajets (
        ID_trajet serial primary key,
        ID_porte_1 smallint references Portes(ID_Porte),
        ID_porte_2 smallint references Portes(ID_Porte),
        longueur real);"""
        ,
        # création de la table contenant les points du trajet
        """create table points_trajet (
        ID_trajet smallint references Trajets,
        Coordinate_X real,
        Coordinate_Y real,
        ordre smallint);"""]
    conn = connexion()
    cur = conn.cursor()
    for commande in Commandes:
        cur.execute(commande)
        conn.commit()


##Remplissage du maillage de taille n*m


def remplir_maillage(n, m):  # cette fonction a pour effet de remplir les différentes tables concernant le maillage
    conn = connexion()
    cur = conn.cursor()

    for i in range(n):
        for j in range(m):
            query = "INSERT INTO maillage1 (x1, y1, occupied, discovered) VALUES (%s, %s, %s, %s);"
            data = (i, j, 0, 0)
            cur.execute(query, data)  # on crée toutes les cases grossières pour (i,j) allant de (0,0) à (n-1,m-1)
            conn.commit()
            for k in range(3):
                for l in range(3):
                    query = "INSERT INTO maillage2 (x1, y1, x2, y2, occupied, discovered, wall, door) VALUES (%s, %s, %s, %s, %s, %s, %s, %s);"
                    data = (i, j, k, l, 0, 0, 0, 0)
                    cur.execute(query,
                                data)  # pour chaque (i,j) on crée toutes les cases intermédiaires pour (k,l) allant de (0,0) à (2,2)
                    conn.commit()
                    for a in range(3):
                        for b in range(3):
                            query = "INSERT INTO maillage3 (x1, y1, x2, y2, x3, y3, occupied, discovered) VALUES (%s, %s, %s, %s, %s, %s, %s, %s);"
                            data = (i, j, k, l, a, b, 0, 0)
                            cur.execute(query,
                                        data)  # pour chaque (i,j,k,l) on crée toutes les cases fines pour (a,b) allant de (0,0) à (2,2)
                            conn.commit()


## Remplissage des portes et trajets :

def nouvelle_porte(x, y, width, orientation):
    conn = connexion()
    cur = conn.cursor()
    query = "INSERT INTO portes (coordinate_x, coordinate_y, width, orientation) VALUES (%s, %s, %s, %s);"
    data = (x, y, width, orientation)
    cur.execute(query, data)  # création de la porte correspondant aux données entrées
    (X1, Y1, X2, Y2, X3, Y3) = getCaseMaillage(x, y)
    query = "UPDATE maillage2 SET door = 1 WHERE X1={0} and Y1={1} and X2={2} and Y2 = {3};".format(X1, Y1, X2, Y2)
    cur.execute(query)
    conn.commit()


def nouveau_mur(X1, Y1, X2, Y2):
    conn = connexion()
    cur = conn.cursor()
    query = "UPDATE maillage2 SET wall = 1 WHERE X1={0} and Y1={1} and X2={2} and Y2 = {3};".format(X1, Y1, X2, Y2)
    cur.execute(query)
    conn.commit()


def calcul_longueur(liste_points):  # calcul de la longueur d'un chemin défini par une liste de couples (x,y)
    l = 0
    for i in range(len(liste_points) - 1):
        l += sqrt(
            (liste_points[i][0] - liste_points[i + 1][0]) ** 2 + (liste_points[i][1] - liste_points[i + 1][1]) ** 2)
    return (l)


def nouveau_trajet(porte_1, porte_2, liste_points):
    conn = connexion()
    cur = conn.cursor()

    query = "INSERT INTO trajets (id_porte_1, id_porte_2, longueur) VALUES (%s, %s, %s);"  # création du nouveau chemin avec la longueur calculée grâce à la fonction calcul_longueur
    data = (porte_1, porte_2, calcul_longueur(liste_points))
    cur.execute(query, data)
    conn.commit()

    query = "select id_trajet from trajets where id_porte_1 = {0} and id_porte_2 = {1}".format(porte_1,
                                                                                               porte_2)  # récupération de l'Id_trajet qui vient d'être créé afin de rentrer les points
    cur.execute(query)
    id_trajet = cur.fetchall()  # id_trajet est de la forme [(x,)], on accède donc à l'information avec id-trajet[0][0]

    for i in range(len(liste_points)):  # on crée ensuite les points dans la tables correspondantes
        query = "INSERT INTO points_trajet (id_trajet, coordinate_x, coordinate_y, ordre) VALUES (%s, %s, %s, %s);"
        data = (id_trajet[0][0], liste_points[i][0], liste_points[i][1], i)
        cur.execute(query, data)
    conn.commit()


## Essai de définition de trajet 


def getCaseMaillage(x, y):  # à partir de coordonnées x,y renvoie la position dans les maillages 1, 2 et 3
    X1 = (x * 100 // (100 * L1))
    Y1 = (y * 100 // (100 * L1))
    (x, y) = ((x * 100 % (100 * L1)) / 100, (y * 100 % (100 * L1)) / 100)
    X2 = (x * 100 // (100 * L2))
    Y2 = (y * 100 // (100 * L2))
    (x, y) = ((x * 100 % (100 * L2)) / 100, (y * 100 % (100 * L2)) / 100)
    X3 = (x * 100 // (100 * L3))
    Y3 = (y * 100 // (100 * L3))
    return ((X1, Y1, X2, Y2, X3, Y3))


class Queue:  # implémentation d'une file en python
    def __init__(self):
        self.elements = collections.deque()

    def empty(self):
        return len(self.elements) == 0

    def put(self, x):
        self.elements.append(x)

    def get(self):
        return self.elements.popleft()


class Quadrillage:  # implémentation d'un quadrillage permettant d'utiliser un algo de recherche de chemins à travers des obstacles
    def __init__(self, xmin, xmax, ymin, ymax):
        self.xmin = xmin
        self.xmax = xmax
        self.ymin = ymin
        self.ymax = ymax
        self.walls = []  # liste des cases innaccessibles du quadrillage

    def dans_la_zone(self, id):  # méthode qui vérifie si la case considérée appartient à la zone étudiée
        (x, y) = id
        return self.xmin <= x < self.xmax and self.ymin <= y < self.ymax

    def accessible(self, id):  # vérifie que la case est libre
        return id not in self.walls

    def cases_adjacentes_accessibles(self, id):  # renvoie la liste des cases voisines libres
        (x, y) = id
        results = [(x + 1, y), (x, y - 1), (x - 1, y), (x, y + 1), (x + 1, y + 1), (x - 1, y + 1), (x + 1, y - 1),
                   (x - 1, y - 1)]
        results = filter(self.dans_la_zone, results)
        results = filter(self.accessible, results)
        return results


def coordPorte(id_porte):  # fonction qui prend en argument l'id_porte et qui renvoie les coordonnées dans le maillage intermédiaire (non compris entre 0 et 2)
    conn = connexion()
    cur = conn.cursor()

    cur.execute("select * from portes where id_porte = {0}".format(id_porte))  # récupération des données des portes
    porte = cur.fetchall()
    print(porte)
    A = getCaseMaillage(porte[0][1], porte[0][2])
    xp = 3 * A[0] + A[2]  # calcul des coordonnées dans le mailage intermédiaire
    yp = 3 * A[1] + A[3]
    return (xp, yp)


def recupMurs(xmin, xmax, ymin, ymax):  # récupère les cases contenant des murs dans la zone considérée
    conn = connexion()
    cur = conn.cursor()
    Walls = []
    for i in range(int(xmin) + 1, int(xmax) + 1):
        for j in range(int(ymin) + 1, int(ymax) + 1):
            cur.execute(
                "select * from maillage2 where X1={0} and Y1={1} and X2 ={2} and Y2 ={3}".format(i // 3, j // 3, i % 3,
                                                                                                 j % 3))
            case = cur.fetchall()

            if case[0][6] == 1:
                Walls += [(i, j)]
    return (Walls)


def GenereQuadrillage(xp1, yp1, xp2,
                      yp2):  # on place en argument les coordonnées des 2 portes dans les maillage intermédiaire

    xmin = max(min(xp1, xp2) - 10, 0)
    xmax = min(max(xp1, xp2) + 10, 3 * n - 1)
    ymin = max(min(yp1, yp2) - 10, 0)
    ymax = min(max(yp1, yp2) + 10, 3 * m - 1)

    G = Quadrillage(xmin, xmax, ymin, ymax)

    Walls = recupMurs(xmin, xmax, ymin, ymax)
    G.walls = Walls
    return (G)


def breadth_first_search(graph, start,
                         goal):  # cette fonction renvoie un dictionaire contenant pour chaque case la case d'origine lors de la découverte
    frontier = Queue()
    frontier.put(start)
    came_from = {}
    came_from[start] = None

    while not frontier.empty():
        current = frontier.get()

        if current == goal:
            break

        for next in graph.cases_adjacentes_accessibles(current):
            if next not in came_from:
                frontier.put(next)
                came_from[next] = current

    return came_from


def reconstruire_trajet(came_from, start,
                        goal):  # reconstruit le trajet réalisé à partir du dictionnaire et des points de départ et d'arrivée
    L = [goal]
    current = goal
    while current != start:
        current = came_from[current]
        L = [current] + L
    return (L)


def casesToPoints(
        liste_cases):  # permet de passer de la liste de cases renvoyée par l'algo de recherche ded chemin à une liste de coordonnées stockable dans la base
    liste_points = []
    for i in liste_cases:
        liste_points = liste_points + [((i[0] + 0.5) * L2, (i[1] + 0.5) * L2)]

    return (liste_points)


def Recherche_trajet(id_porte_1,
                     id_porte_2):  # renvoie la liste de points obtenue après reconstruction du trajet calculé à partir de l'id_porte
    (xp1, yp1) = coordPorte(id_porte_1)
    (xp2, yp2) = coordPorte(id_porte_2)
    G = GenereQuadrillage(xp1, yp1, xp2, yp2)
    came_from = breadth_first_search(G, (xp1, yp1), (xp2, yp2))
    liste_cases = reconstruire_trajet(came_from, (xp1, yp1), (xp2, yp2))
    liste_points = casesToPoints(liste_cases)
    return (liste_points)


def Trajet(id_porte_1, id_porte_2):  # remplit les tables correspondantes
    liste_points = Recherche_trajet(id_porte_1, id_porte_2)
    nouveau_trajet(id_porte_1, id_porte_2, liste_points)


## Lien avec la partie parcours en mode navigation

def getMatriceDadjacence():
    conn = connexion()
    cur = conn.cursor()

    cur.execute("select * from portes")  # récupération du nombre de portes pour générer la matrice
    nb_portes = len(cur.fetchall())
    print(nb_portes)
    cur.execute("select * from trajets")  # récupération des différents trajets
    records = cur.fetchall()

    M = [[-1 for i in range(0, nb_portes)] for j in range(0, nb_portes)]
    for i in range(0, nb_portes):
        M[i][i] = 0
    for k in records:
        print(k)
        M[k[1] - 1][k[2] - 1] = k[3]  # remplissage de la matrice
        M[k[2] - 1][k[1] - 1] = k[3]

    return M


def getPortesMurs():
    conn = connexion()
    cur = conn.cursor()
    M = [[0 for i in range(0, 3 * n)] for j in range(0, 3 * m)]

    for i in range(n):
        for j in range(m):
            for k in range(3):
                for l in range(3):
                    cur.execute("select * from maillage2 where X1={0} and Y1={1} and X2={2} and Y2={3}".format(i, j, k,
                                                                                                               l))  # récupération des différentes cases du maillage intermédiaire
                    case = cur.fetchall()
                    if case[0][6] == 1 and case[0][7] == 1:  # porte + mur
                        M[3 * m - 1 - 3 * j - l][3 * i + k] = 3
                    elif case[0][6] == 0 and case[0][7] == 1:  # juste porte
                        M[3 * m - 1 - 3 * j - l][3 * i + k] = 2
                    elif case[0][6] == 1 and case[0][7] == 0:  # juste mur
                        M[3 * m - 1 - 3 * j - l][3 * i + k] = 1
    return (M)
