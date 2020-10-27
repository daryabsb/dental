from datetime import date
from django.db import models
from django.urls import reverse
from django.utils import timezone
import datetime
from django.apps import apps
from multiselectfield import MultiSelectField


from django.contrib.auth.models import AbstractBaseUser, BaseUserManager
from django.contrib.auth.models import PermissionsMixin

from django.conf import settings

from django.db.models import Sum

# CALCULATE AGE:
def calculateAge(birthDate): 
    today = date.today() 
    age = today.year - birthDate.year - (
        (today.month, today.day) < (birthDate.month, birthDate.day)
        ) 
  
    return age 


class UserManager(BaseUserManager):

    def create_user(self, email, password=None, **extra_fields):
        # Creates and save a new user
        if not email:
            raise ValueError('Users must have an email address!')

        user = self.model(email=self.normalize_email(email), **extra_fields)
        user.set_password(password)
        user.save(using=self._db)

        return user

    def create_superuser(self, email, password):
        # Creates and save a new superuser
        user = self.create_user(email, password)
        user.is_staff = True
        user.is_superuser = True
        user.save(using=self._db)
        return user


class User(PermissionsMixin, AbstractBaseUser):
    # Custom user model supports email instead of username
    email = models.EmailField(max_length=255, unique=True)
    name = models.CharField(max_length=255)
    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ('-created',)

    objects = UserManager()

    USERNAME_FIELD = 'email'


GENDER = (
    ('male', 'MALE'),
    ('female', 'FEMAIL'),
)

class Doctor(models.Model):
    user = models.ForeignKey('User', on_delete=models.CASCADE, related_name='doctors')
    name = models.CharField(max_length=60)
    degree = models.CharField(max_length=60)
    dob = models.DateField()
    age = models.PositiveIntegerField(blank=True, null=True)
    gender = models.CharField(max_length=10, choices=GENDER)
    address = models.ForeignKey(
        'Address', on_delete=models.SET_NULL, 
        null=True, blank=True)
    phone = models.CharField(max_length=60, null=True, blank=True)
    email = models.EmailField(max_length=60)
    description = models.TextField(null=True, blank=True)
    status = models.BooleanField(default=True)

    def __str__(self):
        return self.name

    def get_absolute_url(self):
        return reverse('doctors_detail', kwargs={'pk': self.pk})

    def get_update_url(self):
        return reverse('doctors_update', kwargs={'pk': self.pk})

    def get_delete_url(self):
        return reverse('doctors_delete', args=(self.pk,))


class Address(models.Model):
    address_line1 = models.CharField(max_length=60)

    def __str__(self):
        return self.address_line1



WEEKDAYS = (
    ('saturday', 'Saturday'),
    ('sunday', 'Sunday'),
    ('monday', 'Monday'),
    ('tuesday', 'Tuesday'),
    ('wednesday', 'Wednesday'),
    ('thursday', 'Thursday'),
    ('friday', 'Friday'),
)

class Timetable(models.Model):
    user = models.ForeignKey('User', on_delete=models.CASCADE, related_name='timetables')
    name = models.CharField(max_length=60)
    weekdays = MultiSelectField(choices=WEEKDAYS)
    start_time = models.TimeField()
    end_time = models.TimeField()
    description = models.TextField(null=True, blank=True)
    
    def __str__(self):
        return self.name
        # return f'{self.name} - {self.weekdays}'

class Schedule(models.Model):
    user = models.ForeignKey('User', on_delete=models.CASCADE, related_name='schedules')
    doctor = models.ForeignKey('Doctor', on_delete=models.CASCADE)
    timetable = models.ForeignKey('Timetable', on_delete=models.CASCADE)
    start_date = models.DateTimeField()
    end_date = models.DateTimeField(null=True, blank=True)
    note = models.TextField(blank=True, null=True)


    def __str__(self):
        return f'{self.doctor.name} - {self.timetable.name}'

    def get_update_url(self):
        return reverse('doctors_schedule_update', args=(self.pk,))

    def get_delete_url(self):
        return reverse('doctors_schedule_delete', args=(self.pk,))

class Patient(models.Model):
    user = models.ForeignKey('User', on_delete=models.CASCADE, related_name='patients')
    name = models.CharField(max_length=60)
    dob = models.DateField()
    age = models.PositiveIntegerField(null=True, blank=True)
    gender = models.CharField(max_length=10, choices=GENDER)
    address = models.ForeignKey(
        'Address', on_delete=models.SET_NULL, 
        null=True, blank=True)
    phone = models.CharField(max_length=60, null=True, blank=True)
    email = models.EmailField(max_length=60)
    description = models.TextField(null=True, blank=True)
    status = models.BooleanField(default=True)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)
    doctor = models.ForeignKey(
        'Doctor', on_delete=models.SET_NULL, 
        null=True, blank=True)

    class Meta:
        ordering = ('-created',)


    def __str__(self):
        return self.name

    def save(self, *args, **kwargs):
        if not self.pk is None:
            self.age = calculateAge(self.dob)
        super(Patient, self).save(*args, **kwargs)

    @property
    def treatments(self):
        return self.treatment_set()

    def get_absolute_url(self):
        return reverse('patients_detail', kwargs={'pk': self.pk})

    def get_update_url(self):
        return reverse('patients_update', args=(self.pk,))

    def get_delete_url(self):
        return reverse('patients_delete', args=(self.pk,))

class Appointment(models.Model):
    user = models.ForeignKey('User', on_delete=models.CASCADE, related_name='appointments')
    patient = models.ForeignKey(
        'Patient', on_delete=models.SET_NULL, 
        null=True, blank=True)
    date = models.DateField()
    time = models.TimeField()
    note = models.TextField(null=True, blank=True)

    class Meta:
        ordering = ('-date',)

    def __str__(self):
        return f'{self.patient} - {self.date}({self.time})'

    def get_update_url(self):
        return reverse('appointments_update', args=(self.pk,))

    def get_delete_url(self):
        return reverse('appointments_delete', args=(self.pk,))

class CurrentPatients(models.Model):
    user = models.ForeignKey('User', on_delete=models.CASCADE, related_name='currents')
    patient = models.ForeignKey(
        'Patient', on_delete=models.CASCADE)

    arrive_time = models.DateTimeField(auto_now_add=True)
    appointment = models.ForeignKey(
        'Appointment', on_delete=models.CASCADE)

class Attachment(models.Model):
    # user = models.ForeignKey('User', on_delete=models.CASCADE)
    filename = models.CharField(max_length=120)
    file = models.FileField(upload_to='upload_files')
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    # def __unicode__(self):
    #     return self.file.url
    
    def __str__(self):
        return self.file.url

class Treatment(models.Model):
    user = models.ForeignKey('User', on_delete=models.CASCADE)
    patient = models.ForeignKey('Patient', on_delete=models.CASCADE, related_name='treatments')
    title = models.CharField(max_length=90, default='Treatment')
    description = models.CharField(max_length=200)
    files = models.ManyToManyField('Attachment')
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ('-created',)

    @property
    def upload_files(self):
        return self.attachment_set()

    def __str__(self):
        return f'{self.patient.name} - {self.created}'



