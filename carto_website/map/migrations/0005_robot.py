# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('map', '0004_pieces_points_type_point'),
    ]

    operations = [
        migrations.CreateModel(
            name='robot',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('pos_x', models.IntegerField()),
                ('pos_y', models.IntegerField()),
                ('bat', models.IntegerField()),
                ('ip', models.GenericIPAddressField(protocol=b'IPv4')),
            ],
            options={
            },
            bases=(models.Model,),
        ),
    ]
