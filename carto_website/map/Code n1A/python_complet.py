# -*- coding: utf-8 -*-

# from python_lucas import *
from python_adrien import *

##Connexion à la base de données
def connexion():
    try:
        conn = psycopg2.connect("dbname='Cartographie' user='postgres' host='localhost' password='adgic8734'")
        cur = conn.cursor()
        print ("connexion réussie")
    except:
        print ("échec de la connexion")
    return cur,conn


##Création des tables 
def initialise():
    cur.conn = connexion()
    cur.execute("DROP SCHEMA IF EXISTS BDD CASCADE; CREATE SCHEMA BDD; SET search_path TO BDD;")
    conn.commit()
    cur.execute(open("bdd_espace.sql", "r").read())
    conn.commit()
    cur.execute(open("bdd_maillage.sql","r").read())
    conn.commit()
    return cur,conn
