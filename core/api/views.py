from rest_framework.decorators import action
from rest_framework.response import Response

from django.http import Http404
from rest_framework.views import APIView
from rest_framework import status


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


"""
class ListFiles(APIView):
   
    authentication_classes = [authentication.SessionAuthentication]
    permission_classes = [permissions.IsAdminUser]

    def get(self, request, format=None):
       
        print(request)
        files = Attachment.objects.all()
        serializer = AttachmentSerializer(files)
        return Response(serializer.data)
"""





class FileList(APIView):
    """
    List all snippets, or create a new snippet.
    """
    def get(self, request, format=None):
        files = Attachment.objects.all()
        serializer = AttachmentSerializer(files, many=True)
        return Response(serializer.data)

    def post(self, request, format=None):
        print(request)
        serializer = AttachmentSerializer(data=request.data)
        print(serializer.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_410_BAD_REQUEST)