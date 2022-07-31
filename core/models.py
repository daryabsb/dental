from datetime import date
import uuid
import os
from django.db import models
from django.urls import reverse
from django.utils import timezone
import datetime
from datetime import timedelta
from django.apps import apps
from multiselectfield import MultiSelectField

from PyPDF2 import PdfFileReader

from django.contrib.auth.models import AbstractBaseUser, BaseUserManager
from django.contrib.auth.models import PermissionsMixin

from django.conf import settings
from django.db.models.signals import post_save

from django.db.models import Sum

# CALCULATE AGE:
def calculateAge(birthDate): 
    today = date.today() 
    age = today.year - birthDate.year - (
        (today.month, today.day) < (birthDate.month, birthDate.day)
        ) 
  
    return age

def save_pdf_pages_attachment(sender, instance, created, **kwargs):

    if created:
        instance.save()

def profile_image_file_path(instance, filename):
    # Generate file path for new recipe image
    ext = filename.split('.')[-1]
    filename = f'{uuid.uuid4()}.{ext}'

    return os.path.join('uploads/profile/', filename)



def pdf_page_count(link):
    # Load the pdf to the PdfFileReader object with default settings
    with open(link, "rb") as pdf_file:
        pdf_reader = PdfFileReader(pdf_file)
        num = pdf_reader.numPages
        print(f"The total number of pages in the pdf document is {pdf_reader.numPages}")
    return num
    


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
    image = models.ImageField(null=True, blank=True, upload_to=profile_image_file_path)
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

# class PatientManager(BaseUserManager):
    
#     def create(self, examinations, **extra_fields):
#         # Creates and save a new user
        
#         patient = self.model(**extra_fields)
#         patient.save(using=self._db)
        
#         clinical_examinations = ClinicalExamination(
#             patient=patient, **examinations
#         )
#         clinical_examinations.save()
#         return patient

class Patient(models.Model):
    user = models.ForeignKey('User', on_delete=models.CASCADE, related_name='patients')
    name = models.CharField(max_length=60)
    dob = models.DateField()
    date_bonding = models.DateField(null=True, blank=True)
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
    image = models.ImageField(null=True, blank=True, upload_to=profile_image_file_path)
    # image = models.ImageField(
    #     upload_to=product_image_file_path,
    #     default='uploads/product/4edc7b2c-0f96-4fb6-a8bc-22a61e47cd6f.png')

    class Meta:
        ordering = ('-created',)

    def __str__(self):
        return self.name

    def save(self, *args, **kwargs):
        if not self.pk is None:
            self.age = calculateAge(self.dob)
        if self.pk is None: 
            if self.gender == 'male':
                self.image = 'uploads/product/05e9ff3c-ee03-439b-8bc3-ad38b56a4859.png'
            else:
                self.image = 'uploads/product/4edc7b2c-0f96-4fb6-a8bc-22a61e47cd6f.png'
        print(self.image)
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
FILE_TYPE = (
    ('pdf', 'PDF'),
    ('image', 'IMAGE')
)

class TreatmentTemplate(models.Model):
    MODULE_TYPE = (
        ('Appointment','Appointment'),
        ('Treatment','Treatment'),
        ('Operation','Operation'),
    )
    user = models.ForeignKey('User', on_delete=models.CASCADE)
    module = models.CharField(max_length=20,choices=MODULE_TYPE, default='Treatment')
    title = models.CharField(max_length=120)
    description = models.TextField(blank=True, null=True)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f'{self.module} - {self.title}'


class Attachment(models.Model):
    user = models.ForeignKey('User', on_delete=models.CASCADE)
    patient = models.ForeignKey('Patient', on_delete=models.CASCADE, related_name='attachments')
    filename = models.CharField(max_length=120)
    file = models.FileField(upload_to='upload_files')
    page_count = models.PositiveIntegerField(null=True, blank=True)
    file_type = models.CharField(max_length=15,choices=FILE_TYPE, null=True, blank=True)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    # def __unicode__(self):
    #     return self.file.url
    
    def __str__(self):
        return self.file.url

    def save(self, *args, **kwargs):
        if not self.pk is None and self.file_type == 'pdf':
            pdf = f'{settings.BASE_DIR}{self.file.url}'
            self.page_count = pdf_page_count(pdf)
        else:
            self.page_count = 1
        super(Attachment, self).save(*args, **kwargs)

post_save.connect(save_pdf_pages_attachment, Attachment)

class Treatment(models.Model):
    user = models.ForeignKey('User', on_delete=models.CASCADE)
    patient = models.ForeignKey('Patient', on_delete=models.CASCADE, related_name='treatments')
    title = models.CharField(max_length=90, default='Treatment')
    # description = models.CharField(max_length=200)
    description = models.TextField(blank=True, null=True)
    files = models.ManyToManyField('Attachment', related_name='treatments', blank=True)
    has_appointment = models.BooleanField(default=False)
    appointment = models.ForeignKey(
        'ComingTreatment', 
        on_delete=models.SET_NULL, 
        null=True, 
        blank=True
        )
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ('-created',)

    @property
    def upload_files(self):
        return self.attachment_set()

    def save(self, *args, **kwargs):
        if self.appointment is not None:
            self.has_appointment = True
        super(Treatment, self).save(*args, **kwargs)    

    def __str__(self):
        return f'{self.patient.name} - {self.created}'

class ComingTreatment(models.Model):
    user = models.ForeignKey('User', on_delete=models.CASCADE)
    patient = models.ForeignKey('Patient', on_delete=models.CASCADE, related_name='appointments')
    title = models.CharField(max_length=200, blank=True, null=True)
    description = models.CharField(max_length=200, null=True, blank=True)
    date = models.DateTimeField()
    date_to = models.DateTimeField(null=True, blank=True)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ('-date',)

    def save(self, *args, **kwargs):
        if self.date_to is None:
            self.date_to = self.date + timedelta(hours=1)
        if self.title is None:
            self.title = self.patient.name

        super(ComingTreatment, self).save(*args, **kwargs)

   
    def __str__(self):
        return f'{self.patient.name} - {self.date}'

class ClinicalExamination(models.Model):

    CLASS_CHOICES= (
        ('class1', 'CLASS I'),
        ('class2', 'CLASS II'),
        ('class3', 'CLASS III'),
    )

    NASOLABIAL_ANGLE= (
        ('normal', 'NORMAL'),
        ('acute', 'ACUTE'),
        ('obtuse', 'OBTUCE'),
    )

    NASOLABIAL_SULCUS= (
            ('normal', 'NORMAL'),
            ('deep', 'DEEP'),
        )

    LIP_COMPETENCY= (
            ('competent', 'COMPETENT'),
            ('incompetent', 'INCOMPETENT'),
            ('partially_competent', 'PARTIALLY_COMPETENT'),
        )

    FACE_FORM= (
        ('dolichocephalic', 'DOLICHOCEPHALIC'),
        ('mesocephalic', 'MESOCEPHALIC'),
        ('brachycephalic', 'BRACHYCEPHALIC'),
    )

    MIDLINE_CHOICES= (
        ('coincidence', 'COINIDENCE'),
        ('deviated_to_left', 'DEVIATED TO LEFT'),
        ('deviated_to_right', 'DEVIATED TO RIGHT'),
    )

    ORAL_HYGIENE = (
        ('good', 'GOOD'),
        ('fair', 'FAIR'),
        ('bad', 'BAD'),
    )

    TREATED_ARCH = (
        ('max', 'MAX'),
        ('mand', 'MAND'),
    )

    patient = models.OneToOneField(
        'Patient', 
        on_delete=models.CASCADE, 
        related_name='examinations'
        )

    
# ROW NUMBER 1
    skeletal_class=models.CharField(
        max_length=200, 
        choices=CLASS_CHOICES, 
        default="class1"
        )
    
    nasolabial_angle=models.CharField(
            max_length=200, 
            choices=NASOLABIAL_ANGLE, 
            default='normal'
            )

    nasolabial_sulcus=models.CharField(
            max_length=200, 
            choices=NASOLABIAL_SULCUS, 
            default='normal'
            )
    overjet = models.CharField(max_length=60, default='Diskjet')

# ROW NUMBER 2
    oral_hygiene=models.CharField(
            max_length=200, 
            choices=ORAL_HYGIENE, 
            default='good'
            )
    
    lip_competency=models.CharField(
            max_length=200, 
            choices=LIP_COMPETENCY, 
            default='competent'
            )

    face_form=models.CharField(
            max_length=200, 
            choices=FACE_FORM, 
            default='dolichocephalic'
            )
    habit = models.CharField(max_length=60, default='Naughty')
# ROW NUMBER 3
    treated_arch=models.CharField(
            max_length=200, 
            choices=TREATED_ARCH, 
            default='max'
            )
    
    molar_class_left=models.CharField(
            max_length=200, 
            choices=CLASS_CHOICES, 
            default='class1'
            )

    molar_class_right=models.CharField(
            max_length=200, 
            choices=CLASS_CHOICES, 
            default='class1'
            )
    tongue_size = models.CharField(max_length=60, default='Long')

# ============
# ROW NUMBER 4
    bracket_system=models.CharField(
            max_length=200, 
            choices=CLASS_CHOICES, 
            default='class1'
            )
    
    midline_upper=models.CharField(
            max_length=200, 
            choices=MIDLINE_CHOICES, 
            default='coincidence'
            )

    midline_lower=models.CharField(
            max_length=200, 
            choices=MIDLINE_CHOICES, 
            default='coincidence'
            )
    slot=models.CharField(max_length=60, default='normal')

# ROW NUMBER 5
    extraction_upper=models.CharField(
            max_length=200, 
            choices=CLASS_CHOICES, 
            default='class1'
            )
    extraction_lower=models.CharField(
            max_length=200, 
            choices=CLASS_CHOICES, 
            default='class1'
            )
    anchorage_upper=models.CharField(
            max_length=200, 
            choices=CLASS_CHOICES, 
            default='class1'
            )
    treatment_plan=models.TextField(null=True, blank=True)
    
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f'{self.patient.name} - {self.created}'

class MedicalExamination(models.Model):
    MEDICALS_CONDITIONS = (
        ('95', "EXCELENT"),
        ('75', "GOOD"),
        ('50', "FAIR"),
        ('25', "BAD"),
        ('10', "WORST"),
    )
    patient = models.OneToOneField(
        'Patient', 
        on_delete=models.CASCADE, 
        related_name='medicals'
        )
    physical_restrictions=models.CharField(
            max_length=200, 
            choices=MEDICALS_CONDITIONS, 
            # default=75
            )
    sinus_infections=models.CharField(
            max_length=200, 
            choices=MEDICALS_CONDITIONS, 
            # default=75
            )
    diabetes=models.CharField(
            max_length=200, 
            choices=MEDICALS_CONDITIONS, 
            # default=75
            )
    heart_problem=models.CharField(
            max_length=200, 
            choices=MEDICALS_CONDITIONS, 
            # default=75
            )
    kidney_illness=models.CharField(
            max_length=200, 
            choices=MEDICALS_CONDITIONS, 
            # default=75
            )
    emotional_difficulties=models.CharField(
            max_length=200, 
            choices=MEDICALS_CONDITIONS, 
            default='75'
            )
    other_diseasses=models.TextField(blank=True, null=True)

    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)


    def __str__(self):
        return f'{self.patient.name} - {self.created}'
