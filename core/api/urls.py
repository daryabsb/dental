from django.urls import path, include, re_path
from rest_framework import routers

from .views import AttachmentViewSet, FileUploadView


router = routers.DefaultRouter()
router.register('attachments', AttachmentViewSet)
# router.register(r'invoiceitem', api.InvoiceItemViewSet)
# router.register(r'Receive', api.ReceiveViewSet)


urlpatterns = [
    path('', include(router.urls)),
    re_path(r'^upload/(?P<filename>[^/]+)$', FileUploadView.as_view())
]