from rest_framework.decorators import action
from rest_framework.response import Response

from rest_framework import parsers, viewsets, mixins, status, views

# from rest_framework.authentication import TokenAuthentication
# from rest_framework.permissions import IsAuthenticated

from core.models import Attachment
from .serializers import AttachmentSerializer


class AttachmentViewSet(viewsets.ModelViewSet):
    # Manage ingredientss in the database
    queryset = Attachment.objects.all()
    serializer_class = AttachmentSerializer

    # def perform_create(self, serializer):
    #     """Create a new attachment"""
    #     serializer.save(user=self.request.user)

# views.py
class FileUploadView(views.APIView):
    parser_classes = [parsers.FileUploadParser]

    def put(self, request, filename, format=None):
        file_obj = request.data['file']
        # ...
        # do some stuff with uploaded file
        # ...
        return Response(status=204)
