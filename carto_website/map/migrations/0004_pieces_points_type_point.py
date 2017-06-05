# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('map', '0003_auto_20170604_2134'),
    ]

    operations = [
        migrations.AddField(
            model_name='pieces_points',
            name='type_point',
            field=models.IntegerField(default=0),
            preserve_default=False,
        ),
    ]
