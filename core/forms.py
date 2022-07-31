from django import forms
from core.models import (User, Address, Doctor, Patient, Timetable, Schedule, Treatment, Attachment,)
# from django_select2.forms import Select2Widget,ModelSelect2Widget
# from contact.models import Customer
# from product.models import ProductVariant
from django.forms.models import inlineformset_factory


class DoctorForm(forms.ModelForm):
    
    class Meta:
        model = Doctor
        fields = [
            'name', 'degree','dob','gender', 'description', 'address', 'phone',
            'email', 'status' 
         
        ]

class PatientForm(forms.ModelForm):
    
    class Meta:
        model = Patient
        fields = [
            'name', 'doctor', 'dob', 'gender', 'description', 'address', 'phone',
            'email', 'status' 
         
        ]

class DoctorScheduleForm(forms.ModelForm):
    
    class Meta:
        model = Schedule
        fields = [
            'doctor', 'timetable','start_date','end_date', 'note' 
        ]


class TreatmentForm(forms.ModelForm):
    
    class Meta:
        model = Treatment
        fields = [
            'user', 'patient', 'description','files'
        ]
"""        
        files = forms.ModelMultipleChoiceField(queryset=Attachment.objects.all())

    def __init__(self, *args, **kwargs):
        # Only in case we build the form from an instance
        # (otherwise, 'toppings' list should be empty)
        if kwargs.get('instance'):
            print(kwargs)
            # We get the 'initial' keyword argument or initialize it
            # as a dict if it didn't exist.
            initial = kwargs.setdefault('initial', {})
            # The widget for a ModelMultipleChoiceField expects
            # a list of primary key for the selected data.
            initial['files'] = [f.pk for f in 
                kwargs['instance'].attachment_set.all()]

        forms.ModelForm.__init__(self, *args, **kwargs)

    # Overriding save allows us to process the value of 'toppings' field
    def save(self, commit=True):
        # Get the unsaved Pizza instance
        instance = forms.ModelForm.save(self, False)

        # Prepare a 'save_m2m' method for the form,
        old_save_m2m = self.save_m2m

        def save_m2m():
            old_save_m2m()
            # This is where we actually link the pizza with toppings
            instance.attachment_set.clear()
            for file in self.cleaned_data['files']:
                instance.attachment_set.add(file)

        self.save_m2m = save_m2m

        # Do we need to save all changes now?
        if commit:
            instance.save()
            self.save_m2m()

        return instance

"""

class AddressForm(forms.ModelForm):

    class Meta:
        model = Address
        fields = '__all__'

# InvoiceItemFormSet=inlineformset_factory(Address,Sale,
#     fields=('invoice','item','quantity','unit_price','total',),extra=5,can_delete=True)

