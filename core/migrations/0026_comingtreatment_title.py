# Generated by Django 3.1.2 on 2020-12-04 15:22

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0025_comingtreatment_date_to'),
    ]

    operations = [
        migrations.AddField(
            model_name='comingtreatment',
            name='title',
            field=models.CharField(blank=True, max_length=200, null=True),
        ),
    ]
