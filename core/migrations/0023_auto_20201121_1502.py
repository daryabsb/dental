# Generated by Django 3.1.2 on 2020-11-21 15:02

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0022_auto_20201118_1522'),
    ]

    operations = [
        migrations.AlterField(
            model_name='treatment',
            name='description',
            field=models.TextField(blank=True, null=True),
        ),
    ]