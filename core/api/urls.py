from django.urls import path, include, re_path
from rest_framework import routers

from .views import AttachmentViewSet, FileList


router = routers.DefaultRouter()
router.register('attachments', AttachmentViewSet)
# router.register(r'invoiceitem', api.InvoiceItemViewSet)
# router.register(r'Receive', api.ReceiveViewSet)


urlpatterns = [
    path('', include(router.urls)),
    path('upload/', FileList.as_view())
]