from django.urls import path, include, re_path
from rest_framework import routers

from .views import (
    CreateUserView, CreateTokenView, ManageUserView, AttachmentViewSet, 
    PatientViewSet, TreatmentViewSet, UserViewSet, AppointmentViewSet,
    ImageUpdateView, UserImageUpdateView, TreatmentTemplateViewSet)


router = routers.DefaultRouter()
router.register('users', UserViewSet)
router.register('attachments', AttachmentViewSet)
router.register('patients', PatientViewSet)
router.register('treatments', TreatmentViewSet)
router.register('appointments', AppointmentViewSet)
router.register('templates', TreatmentTemplateViewSet)
# router.register(r'Receive', api.ReceiveViewSet)


urlpatterns = [
    path('', include(router.urls)),
    #path('upload/', FileList.as_view()),
    path('user/create/', CreateUserView.as_view(), name='create'),
    path('user/token/', CreateTokenView.as_view(), name='token'),
    path('user/me/', ManageUserView.as_view(), name='me'),
    path("patients/<int:id>/image/", ImageUpdateView.as_view(), name="patient-image-update"),
    path("users/<int:id>/image/", UserImageUpdateView.as_view(), name="user-image-update"),
]