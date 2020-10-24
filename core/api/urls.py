from django.urls import path, include, re_path
from rest_framework import routers

from .views import (
    CreateUserView, CreateTokenView, ManageUserView, AttachmentViewSet, 
    PatientViewSet, TreatmentViewSet,)


router = routers.DefaultRouter()
router.register('attachments', AttachmentViewSet)
router.register('patients', PatientViewSet)
router.register('treatments', TreatmentViewSet)
# router.register(r'Receive', api.ReceiveViewSet)


urlpatterns = [
    path('', include(router.urls)),
    #path('upload/', FileList.as_view()),
    path('user/create/', CreateUserView.as_view(), name='create'),
    path('user/token/', CreateTokenView.as_view(), name='token'),
    path('user/me/', ManageUserView.as_view(), name='me'),
]