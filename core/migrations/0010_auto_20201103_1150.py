# Generated by Django 3.1.2 on 2020-11-03 08:50

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0009_auto_20201103_1134'),
    ]

    operations = [
        migrations.AlterField(
            model_name='treatment',
            name='files',
            field=models.ManyToManyField(to='core.Attachment'),
        ),
    ]
