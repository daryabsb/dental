from django.urls import path, include
from rest_framework import routers

from .views import AttachmentViewSet


router = routers.DefaultRouter()
router.register('attachments', AttachmentViewSet)
# router.register(r'invoiceitem', api.InvoiceItemViewSet)
# router.register(r'Receive', api.ReceiveViewSet)


urlpatterns = [
    path('', include(router.urls))
]