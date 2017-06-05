# -*- coding: utf8 -*-
import models as m
from django.shortcuts import render, redirect


def home(request):
    return render(request, 'map/home.html')


def etat_robot(request):
    return render(request, 'map/etat_robot.html')


def carte_en_cours(request):
    rooms_id = m.pieces.objects.values('id')
    room_dic = []
    porte_dic = []
    # Extract data from the tables
    for values in rooms_id:
        # Combine points data for the room
        info_room = []
        # Obtain id from values
        id_room = values.get('id')
        # Get the list of the points of the room
        ids_point = m.pieces_points.objects.filter(id_piece=id_room).values('id_point', 'type_point').order_by('-indice')
        liste_point = []
        # Extract the coordinates of the points of the room
        for id_point in ids_point:
            liste_point.append(get_coord_point(id_point=id_point.get('id_point')))
        # Combine data for the output
        info_room.append(id_room)
        info_room.append(liste_point)
        room_dic.append(info_room)
        # Combine door data for the room
        info_door = []
        # Get the list of the points of the room
        ids_porte = m.pieces_portes.objects.filter(id_piece=id_room).values('id_porte')
        liste_porte = []
        # Extract the coordinates of the points of the door
        for id_porte in ids_porte:
            liste_porte.append(get_coord_porte(id_porte=id_porte.get('id_porte')))
        # Combine data for the output
        info_door.append(id_room)
        info_door.append(liste_porte)
        porte_dic.append(info_door)

    # Find th biggest width or length in the dataset
    max_size = 0
    for i in room_dic:
        for j in i[1]:
            if j[0] > max_size:
                max_size = j[0]
            if j[1] > max_size:
                max_size = j[1]

    return render(request, 'map/carte_en_cours.html', {'list_room': room_dic, 'list_door': porte_dic, 'size': max_size})


def historique_carte(request):
    return render(request, 'map/historique_carte.html')


def prendre_photo(request):
    return render(request, 'map/prendre_photo.html')


###############################################################################################
# Part relative to db gestion

def get_coord_point(id_point):
    xy = m.points.objects.filter(id=id_point).values('coordonnee_x', 'coordonnee_y')
    return [xy[0].get('coordonnee_x'), xy[0].get('coordonnee_y')]


def get_coord_porte(id_porte):
    porte = m.portes.objects.filter(id=id_porte).values('id_point1', 'id_point2')
    xy1 = get_coord_point(porte[0].get('id_point1'))
    xy2 = get_coord_point(porte[0].get('id_point2'))
    return [xy1, xy2]

'''def add_couple(id1, id2):
    return [get_coord_point(id_point=id1.get('id_point')), get_coord_point(id_point=id2.get('id_point'))]
        L = len(ids_point)
        # Extract the coordinates of the points of the room
            for i in range(1, L - 2):
                if ids_point[i - 1].get('type_point') == 0:
                    liste_point.append(add_couple(ids_point[i - 1], ids_point[i]))
                elif ids_point[i - 1].get('type_point') == 1 and ids_point[i].get('type_point') == 0:
                    #liste_point.append(add_couple(ids_point[i - 1], ids_point[i]))
        # Processing for the last and first points
        if ids_point[L - 1].get('type_point') == 0:
            liste_point.append(add_couple(ids_point[L - 1], ids_point[0]))
        elif ids_point[L - 1].get('type_point') == 1 and ids_point[0].get('type_point') == 0:
            #liste_point.append(add_couple(ids_point[L - 1], ids_point[0]))

# [[1, [[150.0, 25.0], [150.0, 50.0], [150.0, 60.0], [150.0, 100.0], [25.0, 100.0], [25.0, 25.0]]], [2, [[100.0, 100.0], [125.0, 100.0], [150.0, 100.0], [150.0, 200.0], [75.0, 200.0], [75.0, 100.0]]], [3, [[250.0, 150.0], [250.0, 70.0], [250.0, 60.0], [250.0, 25.0], [150.0, 25.0], [150.0, 50.0], [150.0, 60.0], [150.0, 150.0]]], [4, [[350.0, 25.0], [350.0, 100.0], [325.0, 75.0], [300.0, 75.0], [250.0, 150.0], [250.0, 70.0], [250.0, 60.0], [250.0, 25.0]]]]
'''
