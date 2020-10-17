from django.urls import path, include, re_path
from rest_framework import routers

from .views import AttachmentViewSet, PatientViewSet, FileList


router = routers.DefaultRouter()
router.register('attachments', AttachmentViewSet)
router.register('patients', PatientViewSet)
# router.register(r'Receive', api.ReceiveViewSet)


urlpatterns = [
    path('', include(router.urls)),
    path('upload/', FileList.as_view())
]