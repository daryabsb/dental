# Generated by Django 3.1.2 on 2020-10-30 05:01

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0002_auto_20201029_2301'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='attachment',
            name='patient',
        ),
    ]
