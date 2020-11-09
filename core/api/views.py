from rest_framework.decorators import action
from rest_framework.response import Response

from datetime import datetime, timedelta
from .filters import datefilter, get_date_range as delta

from rest_framework import generics, authentication, permissions


from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.settings import api_settings

from django.http import Http404
from rest_framework.views import APIView
from rest_framework import status


from rest_framework import authentication, permissions, parsers, viewsets, mixins, status, views

# from rest_framework.authentication import TokenAuthentication
# from rest_framework.permissions import IsAuthenticated

from core.models import User, Patient, Attachment, Treatment, ComingTreatment
from .serializers import (
    UserListSerializer, UserSerializer, AuthTokenSerializer, AttachmentSerializer, 
    PatientSerializer, TreatmentSerializer, TreatmentListSerializer, AppointmentSerializer,)


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

class UserViewSet(viewsets.ModelViewSet):
    # Manage ingredientss in the database
    queryset = User.objects.all()
    serializer_class = UserListSerializer
    lookup_field = 'id'

class AttachmentViewSet(viewsets.ModelViewSet):
    # Manage ingredientss in the database
    queryset = Attachment.objects.all()
    serializer_class = AttachmentSerializer
    lookup_field = 'id'

    def get_queryset(self):
        """
        Optionally restricts the returned purchases to a given user,
        by filtering against a `username` query parameter in the URL.
        """
        # print(self.request.query_params)
        queryset = Attachment.objects.all()
        patient = self.request.query_params.get('p', None)
        type = self.request.query_params.get('type', None)
        
        if patient is not None:
            queryset = queryset.filter(patient=patient)
        
        if type is not None:
            queryset = queryset.filter(file_type=type)

        return queryset

    def perform_create(self, serializer):
        """Create a new attachment"""
        print(self.request.user)
        serializer.save(user=self.request.user)


class AppointmentViewSet(viewsets.ModelViewSet):
    # Manage ingredientss in the database
    queryset = ComingTreatment.objects.all()
    serializer_class = AppointmentSerializer
    lookup_field = 'id'

    def get_queryset(self):
        """
        Optionally restricts the returned purchases to a given user,
        by filtering against a `username` query parameter in the URL.
        """
        today = datetime.now()
        # print(self.request.query_params)
        queryset = ComingTreatment.objects.all()
        date_query = self.request.query_params.get('dq', None)

        
        query = delta(date_query)

        # print('===date is====')
        # print(query)

        # filter = datefilter(today, query)

        date_str = self.request.query_params.get('date', None)
        if date_str is not None:
            date = datetime.strptime(f'{date_str}T00:00:00Z', '%Y-%m-%dT%H:%M:%SZ')
            end_date = datetime.strptime(f'{date_str}T23:59:00Z', '%Y-%m-%dT%H:%M:%SZ')

        # print(type(date))

        if query is not None:
            queryset = queryset.filter(date__gt=today, date__lt=query)
        
        if date_query == 'custom' and date is not None:
            queryset = queryset.filter(date__gt=date, date__lt=end_date)

        return queryset

    def perform_create(self, serializer):
        """Create a new appointment"""
        serializer.save(user=self.request.user)

class TreatmentViewSet(viewsets.ModelViewSet):
    # Manage ingredientss in the database
    queryset = Treatment.objects.all()
    serializer_class = TreatmentSerializer
    lookup_field = 'id'

    def perform_create(self, serializer):
        print(self.request.user)
        serializer.save(user=self.request.user)

    def get_serializer_class(self):
        # return apropriate serializer class
        if self.action == 'list':
            return TreatmentListSerializer
        return self.serializer_class

class PatientViewSet(viewsets.ModelViewSet):
    # Manage ingredientss in the database
    queryset = Patient.objects.all()
    serializer_class = PatientSerializer
    lookup_field = 'id'

    def perform_create(self, serializer):
        print(self.request.user)
        serializer.save(user=self.request.user)
