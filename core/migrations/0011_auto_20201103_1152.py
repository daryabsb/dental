# Generated by Django 3.1.2 on 2020-11-03 08:52

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0010_auto_20201103_1150'),
    ]

    operations = [
        migrations.AlterField(
            model_name='treatment',
            name='files',
            field=models.ManyToManyField(blank=True, related_name='treatments', to='core.Attachment'),
        ),
    ]