# Generated by Django 3.1.2 on 2020-11-28 15:10

import core.models
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0023_auto_20201121_1502'),
    ]

    operations = [
        migrations.AlterModelOptions(
            name='comingtreatment',
            options={'ordering': ('-date',)},
        ),
        migrations.AddField(
            model_name='user',
            name='image',
            field=models.ImageField(blank=True, null=True, upload_to=core.models.profile_image_file_path),
        ),
    ]
