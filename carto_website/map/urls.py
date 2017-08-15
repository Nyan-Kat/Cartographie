#-*- coding: utf8 -*-
from django.conf.urls import url
from . import views

urlpatterns = [
    url(r'^$', views.home, name='home'),
    url(r'^etat_robot/$', views.etat_robot, name='etat_robot'),
    url(r'^historique_carte/$', views.historique_carte, name='historique_carte'),
    url(r'^carte_en_cours/$', views.carte_en_cours, name='carte_en_cours'),
    url(r'^Data_carte/$', views.Data_carte, name='Data_carte'),
    url(r'^prendre_photo/$', views.prendre_photo, name='prendre_photo'),
    url(r'^infos/$', views.infos, name='infos'),
]

