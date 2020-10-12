from rest_framework.decorators import action
from rest_framework.response import Response

from rest_framework import viewsets, mixins, status

# from rest_framework.authentication import TokenAuthentication
# from rest_framework.permissions import IsAuthenticated

from core.models import Attachment
from .serializers import AttachmentSerializer


class AttachmentViewSet(viewsets.ModelViewSet):
    # Manage ingredientss in the database
    queryset = Attachment.objects.all()
    serializer_class = AttachmentSerializer

    def perform_create(self, serializer):
        """Create a new attachment"""
        serializer.save(user=self.request.user)