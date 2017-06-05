# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('map', '0001_initial'),
    ]

    operations = [
        migrations.RenameField(
            model_name='points',
            old_name='coordonne_x',
            new_name='coordonnee_x',
        ),
        migrations.RenameField(
            model_name='points',
            old_name='coordonne_y',
            new_name='coordonnee_y',
        ),
    ]
