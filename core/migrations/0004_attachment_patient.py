# Generated by Django 3.1.2 on 2020-10-30 05:02

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0003_remove_attachment_patient'),
    ]

    operations = [
        migrations.AddField(
            model_name='attachment',
            name='patient',
            field=models.ForeignKey(default=33, on_delete=django.db.models.deletion.CASCADE, related_name='attachments', to='core.patient'),
            preserve_default=False,
        ),
    ]