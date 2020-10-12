from django.urls import path, include
from rest_framework import routers

# from .api.views import AttachmentViewSet
from . import views

# router = routers.DefaultRouter()
# router.register('attachments', AttachmentViewSet)
# router.register(r'invoiceitem', api.InvoiceItemViewSet)
# router.register(r'Receive', api.ReceiveViewSet)


urlpatterns = (
    # urls for Django Rest Framework API
    path("home", views.Home.as_view(), name="home"),
    # path('', include(router.urls)),
    path("login", views.LoginView.as_view(), name='login'),
    path("logout", views.LogoutView.as_view(), name='logout')
    
)

# DOCTORS URLS
urlpatterns += (
    # urls for Doctor
    path('doctors/', views.DoctorListView.as_view(), name='doctors_list'),
    path('doctors/<int:pk>', views.DoctorDetailView.as_view(), name='doctors_detail'),
    path('doctors/create', views.DoctorCreateView.as_view(), name='doctors_create'),
    path('doctors/update/<int:pk>', views.DoctorUpdateView.as_view(), name='doctors_update'),
    path('doctors/delete/<int:pk>', views.DoctorDeleteView.as_view(), name='doctors_delete'),
    
)

urlpatterns += (
    # urls for Patient
    path('patients/', views.PatientListView.as_view(), name='patients_list'),
    path('patients/<int:pk>', views.PatientDetailView.as_view(), name='patients_detail'),
    path('patients/create', views.PatientCreateView.as_view(), name='patients_create'),
    path('patients/update/<int:pk>', views.PatientUpdateView.as_view(), name='patients_update'),
    path('patients/delete/<int:pk>', views.PatientDeleteView.as_view(), name='patients_delete'),

)


urlpatterns += (
    # urls for Schedule
    path('doctors/schedule', views.DoctorScheduleListView.as_view(), name='doctors_schedule_list'),
    path('doctors/schedule/create', views.DoctorScheduleCreateView.as_view(), name='doctors_schedule_create'),
    path('doctors/schedule/update/<int:pk>', views.DoctorScheduleUpdateView.as_view(), name='doctors_schedule_update'),
    path('doctors/schedule/delete/<int:pk>', views.DoctorScheduleDeleteView.as_view(), name='doctors_schedule_delete'),
)

urlpatterns += (
    # urls for Schedule
    path('appointments/', views.AppointmentListView.as_view(), name='appointments_list'),
    path('appointments/create', views.AppointmentCreateView.as_view(), name='appointments_create'),
    path('appointments/update/<int:pk>', views.AppointmentUpdateView.as_view(), name='appointments_update'),
    path('appointments/delete/<int:pk>', views.AppointmentDeleteView.as_view(), name='appointments_delete'),
)

urlpatterns += (
    # urls for Schedule
    path('patients/<int:pk>/treatments/', views.TreatmentListView.as_view(), name='treatments_list'),
    path('patients/<int:pk>/treatments/create', views.TreatmentCreateView.as_view(), name='treatments_create'),
    # path('appointments/update/<int:pk>', views.AppointmentUpdateView.as_view(), name='appointments_update'),
    # path('appointments/delete/<int:pk>', views.AppointmentDeleteView.as_view(), name='appointments_delete'),
)

