# Generated by Django 3.1.2 on 2020-12-04 14:16

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0024_auto_20201128_1510'),
    ]

    operations = [
        migrations.AddField(
            model_name='comingtreatment',
            name='date_to',
            field=models.DateTimeField(blank=True, null=True),
        ),
    ]
