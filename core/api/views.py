from rest_framework.decorators import action
from rest_framework.response import Response

from django.db.models import Q

from datetime import datetime, timedelta, date as dt
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
    PatientSerializer, TreatmentSerializer, TreatmentListSerializer, AppointmentSerializer,
    PatientPictureSerializer, UserPictureSerializer,)
from .pagination import PatientPagination


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

    def get_queryset(self):
        """
        Optionally restricts the returned purchases to a given user,
        by filtering against a `username` query parameter in the URL.
        """
        queryset = User.objects.all()
        # PERFORM FILTER BY SEARCH INPUT
        conditions = Q()
        keywords = self.request.query_params.get('input', None)
        # print(keywords)
        if keywords:
            
            keywords_list = keywords.split(' ') 
            # print(keywords_list)
            for word in keywords_list:
                conditions |= Q(name__icontains=word) | Q(email__icontains=word)
    
            if conditions:
                # print(type(conditions))
                queryset = User.objects.filter(conditions)

        return queryset

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
        
        queryset = ComingTreatment.objects.all()
        
        # PERFORM FILTER BY SEARCH INPUT
        conditions = Q()
        keywords = self.request.query_params.get('input', None)
        # print(keywords)
        if keywords:
            
            keywords_list = keywords.split(' ')

            print(keywords_list)
            for word in keywords_list:
                conditions |= Q(patient__name__icontains=word) | Q(description__icontains=word)

            
            if conditions:
                # print(type(conditions))
                queryset = ComingTreatment.objects.filter(conditions)

        # PERFORM FILTER BY DATE
        today = datetime.now()
        # print(self.request.query_params)
        date_query = self.request.query_params.get('dq', None)

        
        query = delta(date_query)

        todays_date = dt.today()
        todays_query = datetime.strptime(f'{todays_date}T00:00:00Z', '%Y-%m-%dT%H:%M:%SZ')

        date_str = self.request.query_params.get('date', None)

        if date_str is not None:
            
            date = datetime.strptime(f'{date_str}T00:00:00Z', '%Y-%m-%dT%H:%M:%SZ')
            end_date = datetime.strptime(f'{date_str}T23:59:00Z', '%Y-%m-%dT%H:%M:%SZ')


        if query is not None:
            queryset = queryset.filter(date__gte=todays_query, date__lte=query)
        
        
        
        if date_query == 'custom' and date is not None:
            queryset = queryset.filter(date__gte=date, date__lte=end_date)

        patient_query = self.request.query_params.get('p', None)

        if patient_query is not None:
            queryset = ComingTreatment.objects.filter(patient=patient_query)



        return queryset

    def perform_create(self, serializer):
        """Create a new appointment"""
        serializer.save(user=self.request.user)

class TreatmentViewSet(viewsets.ModelViewSet):
    # Manage ingredientss in the database
    queryset = Treatment.objects.all()
    serializer_class = TreatmentSerializer
    lookup_field = 'id'

    def get_queryset(self):
        
        queryset = Treatment.objects.all()
        
        # PERFORM FILTER BY SEARCH INPUT
        conditions = Q()
        keywords = self.request.query_params.get('input', None)
        # print(keywords)
        if keywords:
            
            keywords_list = keywords.split(' ')
            
            print(keywords_list)
            for word in keywords_list:
                conditions |= Q(patient__name__icontains=word) | Q(description__icontains=word)

            
            if conditions:
                # print(type(conditions))
                queryset = Treatment.objects.filter(conditions)

        # PERFORM FILTER BY DATE
        today = datetime.now()
        # print(self.request.query_params)
        date_query = self.request.query_params.get('dq', None)

        
        query = delta(date_query)

        todays_date = dt.today()
        todays_query = datetime.strptime(f'{todays_date}T00:00:00Z', '%Y-%m-%dT%H:%M:%SZ')

        date_str = self.request.query_params.get('date', None)

        if date_str is not None:
            
            date = datetime.strptime(f'{date_str}T00:00:00Z', '%Y-%m-%dT%H:%M:%SZ')
            end_date = datetime.strptime(f'{date_str}T23:59:00Z', '%Y-%m-%dT%H:%M:%SZ')


        if query is not None:
            queryset = queryset.filter(created__gte=todays_query, created__lte=query)
        
        
        
        if date_query == 'custom' and date is not None:
            queryset = queryset.filter(created__gte=date, created__lte=end_date)

        return queryset

    def perform_create(self, serializer):
        # print(self.request.user)
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
    pagination_class = PatientPagination
    lookup_field = 'id'

    def perform_create(self, serializer):
        print(self.request.user)
        serializer.save(user=self.request.user)

    def get_queryset(self):
        """
        Optionally restricts the returned purchases to a given user,
        by filtering against a `username` query parameter in the URL.
        """
        # print(self.request.query_params)
        queryset = Patient.objects.all()
        
        # PERFORM FILTER BY SEARCH INPUT
        conditions = Q()
        keywords = self.request.query_params.get('input', None)
        # print(keywords)
        if keywords:
            
            keywords_list = keywords.split(' ') 
            print(keywords_list)
            for word in keywords_list:
                conditions |= Q(name__icontains=word) | Q(email__icontains=word)

            
            if conditions:
                # print(type(conditions))
                queryset = Patient.objects.filter(conditions)

        # PERFORM FILTER BY DATE
        # PATIENT OBJECT DOESNT HAVE DATE



        return queryset

class ImageUpdateView(generics.RetrieveUpdateAPIView):
    serializer_class = PatientPictureSerializer
    # permission_classes = [IsAuthenticated]
    lookup_field = 'id'

 
    
    def get_object(self):
        kwarg_id = self.kwargs.get("id")
        obj = Patient.objects.get(id=kwarg_id)
        return obj

class UserImageUpdateView(generics.RetrieveUpdateAPIView):
    serializer_class = UserPictureSerializer
    # permission_classes = [IsAuthenticated]
    lookup_field = 'id'

 
    
    def get_object(self):
        kwarg_id = self.kwargs.get("id")
        obj = User.objects.get(id=kwarg_id)
        return obj
    # def get_object(self):
    #     """
    #     Returns the object the view is displaying.

    #     You may want to override this if you need to provide non-standard
    #     queryset lookups.  Eg if objects are referenced using multiple
    #     keyword arguments in the url conf.
    #     """
        # print('REACHED HERE')
    #     # Determine the base queryset to use.
        # if queryset is None:
        #     queryset = self.filter_queryset(self.get_queryset())
        # else:
        #     pass  # Deprecation warning
        # print(queryset)
    #     # Perform the lookup filtering.
    #     # Note that `pk` and `slug` are deprecated styles of lookup filtering.
        # lookup_url_kwarg = self.lookup_url_kwarg or self.lookup_field
        # print(lookup_url_kwarg)
    #     lookup = self.kwargs.get(lookup_url_kwarg, None)
        # pk = self.kwargs.get(self.pk_url_kwarg, None)
    #     # slug = self.kwargs.get(self.slug_url_kwarg, None)

    #     if lookup is not None:
    #         filter_kwargs = {self.lookup_field: lookup}
    #     elif pk is not None and self.lookup_field == 'pk':
    #         warnings.warn(
    #             'The `pk_url_kwarg` attribute is due to be deprecated. '
    #             'Use the `lookup_field` attribute instead',
    #             PendingDeprecationWarning
    #         )
    #         filter_kwargs = {'pk': pk}
    #     # elif slug is not None and self.lookup_field == 'pk':
    #     #     warnings.warn(
    #     #         'The `slug_url_kwarg` attribute is due to be deprecated. '
    #     #         'Use the `lookup_field` attribute instead',
    #     #         PendingDeprecationWarning
    #     #     )
    #     #     filter_kwargs = {self.slug_field: slug}
    #     else:
    #         raise ImproperlyConfigured(
    #             'Expected view %s to be called with a URL keyword argument '
    #             'named "%s". Fix your URL conf, or set the `.lookup_field` '
    #             'attribute on the view correctly.' %
    #             (self.__class__.__name__, self.lookup_field)
    #         )

    #     print('PASSED')
        

    #     obj = get_object_or_404(queryset, **filter_kwargs)

    #     # May raise a permission denied
    #     # self.check_object_permissions(self.request, obj)

        # return obj

















    # def get_object(self):
    #     print(self.kwargs)
    #     id = self.kwargs['pk']
    #     patient_object = self.get_object(id=id)
    #     return  patient_object
