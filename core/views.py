from datetime import date
from django.views.generic import View
from django.shortcuts import render, HttpResponse, HttpResponseRedirect
from django.urls import reverse, reverse_lazy
from django.conf import settings
from django.contrib.auth import authenticate, login, logout
from django.http import HttpResponse, HttpResponseRedirect


from .models import (
    calculateAge,
    User, Address, Doctor, Patient, Appointment, Schedule,
    Attachment, Treatment,)
from .forms import (
    DoctorForm, PatientForm, DoctorScheduleForm, AppointmentForm,
    TreatmentForm,)

from django.views.generic import View, ListView, CreateView, DetailView, UpdateView, DeleteView


class Home(ListView):
    model = User
    template_name = "index.html"

    def get_context_data(self, *args, **kwargs):
        context = super(Home, self).get_context_data(*args, **kwargs)
        form = PatientForm()
        apt_form = AppointmentForm()
        context['form'] = form
        context['apt_form'] = apt_form

        return context


class LoginView(View):
    template_name = 'login.html'

    def get(self, request):
        return render(request, "login.html")

    def post(self, request):

        username = request.POST['email']
        password = request.POST['password']
        user = authenticate(username=username, password=password)

        if user is not None:
            if user.is_active:
                login(request, user)

                return HttpResponseRedirect('/patients')
            else:
                return HttpResponse("Inactive user.")
        else:
            return HttpResponseRedirect(settings.LOGIN_URL)

        return render(request, "login.html")


class LogoutView(View):
    def get(self, request):
        logout(request)
        return HttpResponseRedirect(settings.LOGIN_URL)


class DoctorListView(ListView):
    # title = Doctors
    model = Doctor
    form_class = DoctorForm
    template_name = 'doctors/doctors_list.html'

    def get_context_data(self, *args, **kwargs):
        context = super(DoctorListView, self).get_context_data(*args, **kwargs)
        form = DoctorForm()
        context['form'] = form

        return context


class DoctorCreateView(CreateView):
    title = 'Create'
    page_head = 'Add a new Doctor'
    model = Doctor
    form_class = DoctorForm
    template_name = 'doctors/doctors_create.html'

    def get_success_url(self):
        return reverse('doctors_list')


class DoctorDetailView(DetailView):
    model = Doctor
    template_name = 'doctors/doctors_detail.html'


class DoctorUpdateView(UpdateView):
    model = Doctor
    form_class = DoctorForm
    template_name = 'doctors/doctors_create.html'


class DoctorDeleteView(DeleteView):
    model = Doctor
    template_name = 'doctors/doctors_delete.html'
    success_url = '/doctors/'


# PATIENT VIEW CLASSES
class PatientListView(ListView):
    title = 'All PAtients'
    page_head = 'Patients List'
    model = Patient
    template_name = 'patients/patients_list.html'

    def get_context_data(self, *args, **kwargs):
        context = super(PatientListView, self).get_context_data(
            *args, **kwargs)
        form = PatientForm()
        apt_form = AppointmentForm()
        context['form'] = form
        context['apt_form'] = apt_form
        # print(context)

        return context



class PatientCreateView(CreateView):
    model = Patient
    form_class = PatientForm
    template_name = 'patients/patients_create.html'
    # success_url = 

    # class PlaceFormView(CreateView):
    #     form_class = PlaceForm

    # @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        return super(PatientCreateView, self).dispatch(*args, **kwargs)

    def form_valid(self, form):
        print(form.cleaned_data)
        obj = form.save(commit=False)
        obj.user = self.request.user
        obj.age = calculateAge(obj.dob)
        print(obj.age)
        obj.save()        
        return  HttpResponseRedirect(self.get_success_url())
    
    def get_success_url(self):
        return reverse('patients_list')


class PatientDetailView(DetailView):
    title = 'Patients Detail'
    model = Patient
    template_name = 'patients/patients_detail.html'

    """
    def get_context_data(self, *args, **kwargs):
        contex = super(PatientDetailView, self).get_context_data(*args, **kwargs)
        patient = self.get_object()
        treatments = Treatment.objects.filter(patient=patient)
        contex['treatments'] = treatments
        return contex
    """

class PatientUpdateView(UpdateView):
    model = Patient
    form_class = PatientForm
    template_name = 'patients/patients_create.html'


class PatientDeleteView(DeleteView):
    model = Patient
    template_name = 'patients/patients_list.html'
    success_url = '/patients/'

    def get(self, *args, **kwargs):
        return self.post(*args, **kwargs)


# SCHEDULE VIEWS

class DoctorScheduleListView(ListView):
    model = Schedule
    template_name = 'doctors/doctors_schedule_list.html'


class DoctorScheduleCreateView(CreateView):
    model = Schedule
    form_class = DoctorScheduleForm
    template_name = 'doctors/doctors_schedule_create.html'
    


class DoctorScheduleUpdateView(UpdateView):
    model = Schedule
    form_class = DoctorScheduleForm
    template_name = 'doctors/doctors_schedule_list.html'


class DoctorScheduleDeleteView(DeleteView):
    model = Schedule


#  APPOINTMENT VIEWS

class AppointmentListView(ListView):
    title = 'Patients Appointments'
    model = Appointment
    template_name = 'appointments/appointment_list.html'

    def get_context_data(self, *args, **kwargs):
        context = super(AppointmentListView, self).get_context_data(*args, **kwargs)
        form = PatientForm()
        apt_form = AppointmentForm()
        context['form'] = form
        context['apt_form'] = apt_form

        return context


class AppointmentCreateView(CreateView):
    model = Appointment
    form_class = AppointmentForm
    template_name = 'appointments/appointment_create.html'

    def dispatch(self, *args, **kwargs):
        return super(AppointmentCreateView, self).dispatch(*args, **kwargs)

    def form_valid(self, form):
        obj = form.save(commit=False)
        obj.user = self.request.user
        obj.save()        
        return  HttpResponseRedirect(self.get_success_url())
    
    def get_success_url(self):
        return reverse('appointments_list')


class AppointmentUpdateView(UpdateView):
    model = Appointment
    form_class = AppointmentForm
    template_name = 'appointments/appointment_update.html'


class AppointmentDeleteView(DeleteView):
    model = Appointment
    template_name = 'patients/appointment_list.html'
    success_url = '/appointments/'

    def get(self, *args, **kwargs):
        return self.post(*args, **kwargs)


class TreatmentListView(ListView):
    model = Treatment


class TreatmentCreateView(CreateView):
    model = Treatment
    form_class = TreatmentForm
    template_name = 'patients/patients_detail.html'
    # success_url = 

    # class PlaceFormView(CreateView):
    #     form_class = PlaceForm

    # @method_decorator(login_required)
    def dispatch(self, *args, **kwargs):
        #print(self.get_patient())
        return super(TreatmentCreateView, self).dispatch(*args, **kwargs)

    def get_patient(self, *args, **kwargs):
        id = self.kwargs['pk']
        patient = Patient.objects.get(id=id)
        return patient

    def get_files(self, *args, **kwargs):
        files = self.kwargs['files']
        print(files)
        return files

    def form_valid(self, form,  *args, **kwargs):
        print(form.cleaned_data['files'])
        print(form.cleaned_data['user'])
        patient = self.get_patient()
        # print(self.get_files)

        
        obj = form.save(commit=True)

        for file in form.cleaned_data['files']:
            obj.files.add(file.id)
        
        # obj.user = self.request.user
                
        # obj.patient = patient
        obj.save()        
        return  HttpResponseRedirect(self.get_success_url())
    
    def get_success_url(self):
        patient = self.get_patient()
        return reverse('patients_detail', args=(patient.id,))
