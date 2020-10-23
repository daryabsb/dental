from rest_framework.decorators import action
from rest_framework.response import Response

from rest_framework import generics, authentication, permissions


from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.settings import api_settings

from django.http import Http404
from rest_framework.views import APIView
from rest_framework import status


from rest_framework import authentication, permissions, parsers, viewsets, mixins, status, views

# from rest_framework.authentication import TokenAuthentication
# from rest_framework.permissions import IsAuthenticated

from core.models import Patient, Attachment, Treatment
from .serializers import (
    UserSerializer, AuthTokenSerializer, AttachmentSerializer, 
    PatientSerializer, TreatmentSerializer,)


class CreateUserView(generics.CreateAPIView):
    """Create a new user in the system"""
    serializer_class = UserSerializer


class CreateTokenView(ObtainAuthToken):
    """Create a new auth token for the user"""
    serializer_class = AuthTokenSerializer
    renderer_classes = api_settings.DEFAULT_RENDERER_CLASSES


class ManageUserView(generics.RetrieveUpdateAPIView):
    # Manage authenticated user
    serializer_class = UserSerializer
    authentication_classes = (authentication.TokenAuthentication,)
    permission_classes = (permissions.IsAuthenticated,)

    def get_object(self):
        # Retrieve and return authenticated user
        return self.request.user


class AttachmentViewSet(viewsets.ModelViewSet):
    # Manage ingredientss in the database
    queryset = Attachment.objects.all()
    serializer_class = AttachmentSerializer
    lookup_field = 'id'

    # def perform_create(self, serializer):
    #     """Create a new attachment"""
    #     serializer.save(user=self.request.user)

class TreatmentViewSet(viewsets.ModelViewSet):
    # Manage ingredientss in the database
    queryset = Treatment.objects.all()
    serializer_class = TreatmentSerializer
    lookup_field = 'id'

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

class PatientViewSet(viewsets.ModelViewSet):
    # Manage ingredientss in the database
    queryset = Patient.objects.all()
    serializer_class = PatientSerializer
    lookup_field = 'id'





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