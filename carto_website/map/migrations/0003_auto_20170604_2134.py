# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('map', '0002_auto_20170604_1954'),
    ]

    operations = [
        migrations.AlterField(
            model_name='points',
            name='coordonnee_x',
            field=models.FloatField(),
            preserve_default=True,
        ),
        migrations.AlterField(
            model_name='points',
            name='coordonnee_y',
            field=models.FloatField(),
            preserve_default=True,
        ),
    ]
