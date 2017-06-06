from django.db import models


class pieces(models.Model):
    def __str__(self):  # __unicode__ on Python 2
        return self.name


class points(models.Model):
    coordonnee_x = models.FloatField()
    coordonnee_y = models.FloatField()

    def __str__(self):  # __unicode__ on Python 2
        return self.name


class portes(models.Model):
    id_point1 = models.IntegerField()
    id_point2 = models.IntegerField()

    def __str__(self):  # __unicode__ on Python 2
        return self.name


class pieces_portes(models.Model):
    id_piece = models.IntegerField()
    id_porte = models.IntegerField()

    def __str__(self):  # __unicode__ on Python 2
        return self.name


class pieces_points(models.Model):
    id_piece = models.IntegerField()
    id_point = models.IntegerField()
    indice = models.IntegerField()
    type_point = models.IntegerField()

    def __str__(self):  # __unicode__ on Python 2
        return self.name


class robot(models.Model):
    pos_x = models.IntegerField()
    pos_y = models.IntegerField()
    bat = models.IntegerField()
    ip = models.GenericIPAddressField(protocol='IPv4')

    def __str__(self):  # __unicode__ on Python 2
        return self.name
