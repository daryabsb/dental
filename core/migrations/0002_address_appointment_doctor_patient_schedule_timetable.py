# Generated by Django 3.1.2 on 2020-10-11 08:21

from django.db import migrations, models
import django.db.models.deletion
import multiselectfield.db.fields


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Address',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('address_line1', models.CharField(max_length=60)),
            ],
        ),
        migrations.CreateModel(
            name='Doctor',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=60)),
                ('degree', models.CharField(max_length=60)),
                ('dob', models.DateField()),
                ('age', models.PositiveIntegerField(blank=True, null=True)),
                ('gender', models.CharField(choices=[('male', 'MALE'), ('female', 'FEMAIL')], max_length=10)),
                ('phone', models.CharField(blank=True, max_length=60, null=True)),
                ('email', models.EmailField(max_length=60)),
                ('description', models.TextField(blank=True, null=True)),
                ('status', models.BooleanField(default=True)),
                ('address', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='core.address')),
            ],
        ),
        migrations.CreateModel(
            name='Timetable',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=60)),
                ('weekdays', multiselectfield.db.fields.MultiSelectField(choices=[('saturday', 'Saturday'), ('sunday', 'Sunday'), ('monday', 'Monday'), ('tuesday', 'Tuesday'), ('wednesday', 'Wednesday'), ('thursday', 'Thursday'), ('friday', 'Friday')], max_length=56)),
                ('start_time', models.TimeField()),
                ('end_time', models.TimeField()),
                ('description', models.TextField(blank=True, null=True)),
            ],
        ),
        migrations.CreateModel(
            name='Schedule',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('start_date', models.DateTimeField()),
                ('end_date', models.DateTimeField(blank=True, null=True)),
                ('note', models.TextField(blank=True, null=True)),
                ('doctor', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.doctor')),
                ('timetable', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.timetable')),
            ],
        ),
        migrations.CreateModel(
            name='Patient',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('name', models.CharField(max_length=60)),
                ('dob', models.DateField()),
                ('age', models.PositiveIntegerField(blank=True, null=True)),
                ('gender', models.CharField(choices=[('male', 'MALE'), ('female', 'FEMAIL')], max_length=10)),
                ('phone', models.CharField(blank=True, max_length=60, null=True)),
                ('email', models.EmailField(max_length=60)),
                ('description', models.TextField(blank=True, null=True)),
                ('status', models.BooleanField(default=True)),
                ('address', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='core.address')),
                ('doctor', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='core.doctor')),
            ],
        ),
        migrations.CreateModel(
            name='Appointment',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('appointment_date', models.DateTimeField()),
                ('patient', models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.SET_NULL, to='core.patient')),
            ],
        ),
    ]