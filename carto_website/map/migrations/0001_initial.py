# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='pieces',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=True, auto_created=True, primary_key=True)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='pieces_points',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=True, auto_created=True, primary_key=True)),
                ('id_piece', models.IntegerField()),
                ('id_point', models.IntegerField()),
                ('indice', models.IntegerField()),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='pieces_portes',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=True, auto_created=True, primary_key=True)),
                ('id_piece', models.IntegerField()),
                ('id_porte', models.IntegerField()),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='points',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=True, auto_created=True, primary_key=True)),
                ('coordonne_x', models.DecimalField(max_digits=5, decimal_places=2)),
                ('coordonne_y', models.DecimalField(max_digits=5, decimal_places=2)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='portes',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=True, auto_created=True, primary_key=True)),
                ('id_point1', models.IntegerField()),
                ('id_point2', models.IntegerField()),
            ],
            options={
            },
            bases=(models.Model,),
        ),
    ]
