# Generated by Django 3.1.2 on 2020-10-23 19:37

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0018_auto_20201017_0912'),
    ]

    operations = [
        migrations.AlterField(
            model_name='treatment',
            name='files',
            field=models.ManyToManyField(blank=True, null=True, to='core.Attachment'),
        ),
    ]
