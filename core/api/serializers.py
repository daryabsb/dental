from django.contrib.auth import get_user_model, authenticate
from rest_framework import serializers
from core.models import (
    Patient, Attachment, Doctor, Treatment, ComingTreatment, 
    ClinicalExamination, MedicalExamination,
    )

class UserListSerializer(serializers.ModelSerializer):

   
    class Meta:
        model = get_user_model()
        fields = ('id','email', 'password', 'name', 'is_staff','created',)
        extra_kwargs = {'password': {'write_only': True, 'min_length': 4, 'required':False}}
        read_only_Fields = ('id',)

        def create(self, validated_data):
            return User.objects.create(**validated_data)

        def update(self, instance, validated_data):
            # password = validated_data.pop('password')
            # Unless the application properly enforces that this field is
            # always set, the following could raise a `DoesNotExist`, which
            # would need to be handled.
            print(instance)

            instance.email = validated_data.get('email', instance.email)
            instance.name = validated_data.get('name', instance.name)
            instance.password = validated_data.get('password', instance.password)
            instance.is_staff = validated_data.get('is_staff', instance.is_staff)
            instance.save()
            return instance

class UserSerializer(serializers.ModelSerializer):
    """Serializer for the users object"""
   
    class Meta:
        model = get_user_model()
        fields = ('id','email', 'password', 'name', 'is_staff')
        extra_kwargs = {'password': {'write_only': True, 'min_length': 4}}
        read_only_Fields = ('id',)

    def create(self, validated_data):
        """Create a new user with encrypted password and return it"""
        return get_user_model().objects.create_user(**validated_data)
    def update(self, instance, validated_data):
        # Update a user, setting the password correctly and return it
        password = validated_data.pop('password', None)
        user = super().update(instance, validated_data)

        if password:
            user.set_password(password)
            user.save()

        return user


class AuthTokenSerializer(serializers.Serializer):
    """Serializer for the user authentication object"""
    email = serializers.CharField()
    password = serializers.CharField(
        style={'input_type': 'password'},
        trim_whitespace=False
    )

    def validate(self, attrs):
        """Validate and authenticate the user"""
        email = attrs.get('email')
        password = attrs.get('password')
        
        user = authenticate(
            request=self.context.get('request'),
            email=email,
            password=password
        )
       
        if not user:
            msg = _('Unable to authenticate with provided credentials')
            raise serializers.ValidationError(msg, code='authorization')
        
        attrs['user'] = user
        return attrs

# GET CHOICES WITH DISPLAY
class ChoiceField(serializers.ChoiceField):
    
    def to_representation(self, obj):
        if obj == '' and self.allow_blank:
            return obj
        return self._choices[obj]

    def to_internal_value(self, data):
        # To support inserts with the value
        if data == '' and self.allow_blank:
            return ''

        for key, val in self._choices.items():
            if val == data:
                return key
        self.fail('invalid_choice', input=data)


class AttachmentSerializer(serializers.ModelSerializer):
    # Serializer for uploading images for recipes

    class Meta:
        model = Attachment
        fields = ('id', 'patient', 'file_type', 'filename', 'file', 'page_count')
        read_only_Fields = ('id','page_count')

    # def create(self, validated_data):
        
    #     file = Attachment(
    #         patient=validated_data['patient'],
    #         file=validated_data['file'], 
    #         filename=validated_data['filename']
    #         )
    #     file.save()

    #     # print('==|==|==')
    #     # print(validated_data['file'])
    #     # print('==|==|==')

    #     return file


class AppointmentSerializer(serializers.ModelSerializer):
    # Serializer for uploading images for recipes

    # patient = serializers.PrimaryKeyRelatedField(read_only=True)

    class Meta:
        model = ComingTreatment
        fields = ('id', 'patient', 'description', 'date')
        read_only_Fields = ('id',)


class TreatmentSerializer(serializers.ModelSerializer):
    # Serializer for uploading images for recipes

    # files = serializers.PrimaryKeyRelatedField(
    #     queryset=Attachment.objects.all(),
    #     many=True
    # )
    # files = AttachmentSerializer(many=True)
    # files = AttachmentSerializer
    
    class Meta:
        model = Treatment
        fields = [
            'id', 'patient', 'title', 'description', 'files', 'created'         
        ]
        read_only_Fields = ('id','created',)

class TreatmentListSerializer(serializers.ModelSerializer):
    # Serializer for uploading images for recipes

    # files = serializers.PrimaryKeyRelatedField(
    #     queryset=Attachment.objects.all(),
    #     many=True
    # )
    files = AttachmentSerializer(many=True)
    # files = AttachmentSerializer
    
    class Meta:
        model = Treatment
        fields = [
            'id', 'patient', 'title', 'description', 'files', 'created'         
        ]
        read_only_Fields = ('id','created',)

class ClinicalExaminationSerializer(serializers.ModelSerializer):

    # skeletal_class = ChoiceField(ClinicalExamination.CLASS_CHOICES)
    # nasolabial_angle = ChoiceField(ClinicalExamination.NASOLABIAL_ANGLE)
    # nasolabial_sulcus = ChoiceField(ClinicalExamination.NASOLABIAL_SULCUS)
    # lip_competency = ChoiceField(ClinicalExamination.LIP_COMPETENCY)
    # face_form = ChoiceField(ClinicalExamination.FACE_FORM)
    # molar_class_left = ChoiceField(ClinicalExamination.CLASS_CHOICES)
    # molar_class_right = ChoiceField(ClinicalExamination.CLASS_CHOICES)
    # midline_upper = ChoiceField(ClinicalExamination.MIDLINE_CHOICES)
    # midline_lower = ChoiceField(ClinicalExamination.MIDLINE_CHOICES)
    # oral_hygiene = ChoiceField(ClinicalExamination.ORAL_HYGIENE)
    # treated_arch = ChoiceField(ClinicalExamination.TREATED_ARCH)
    # skeletal_class = ChoiceField(ClinicalExamination.CLASS_CHOICES)
    # skeletal_class = ChoiceField(ClinicalExamination.CLASS_CHOICES)
    patient = serializers.PrimaryKeyRelatedField(queryset=Patient.objects.all(), required=False)

    class Meta:
        model = ClinicalExamination
        fields = [
            'id', 'patient','skeletal_class', 'nasolabial_angle','nasolabial_sulcus',
            'lip_competency','face_form','molar_class_left', 'molar_class_right','midline_upper',
            'midline_lower','overjet','oral_hygiene', 'tongue_size', 'habit','treatment_plan','slot','treated_arch', 'bracket_system',
            'extraction_upper','extraction_lower','anchorage_upper','created', 'updated'
        ]
        read_only_Fields = ('id','created','updated',)



class MedicalExaminationSerializer(serializers.ModelSerializer):
    

    patient = serializers.PrimaryKeyRelatedField(
        queryset=Patient.objects.all(), 
        required=False
        )

    class Meta:
        model = MedicalExamination
        fields = [
            'id', 'patient','physical_restrictions','sinus_infections','diabetes','heart_problem',
            'kidney_illness','emotional_difficulties','other_diseasses','created','updated'
        ]
        read_only_Fields = ('id','created','updated',)


class PatientSerializer(serializers.ModelSerializer):
   
    treatments = TreatmentSerializer(many=True, required=False)
    appointments = AppointmentSerializer(many=True, required=False)
    attachments = AttachmentSerializer(many=True, required=False)
    examinations = ClinicalExaminationSerializer()
    medicals = MedicalExaminationSerializer()

    class Meta:
        model = Patient
        fields = [
            'id', 'name', 'doctor', 'dob', 'gender', 'description', 'phone', 
            'email', 'image', 'treatments', 'appointments', 'attachments', 
            'examinations','medicals', 'status'
         
        ]
        read_only_Fields = ('id',)

    
    def create(self, validated_data):
        print(validated_data)
        examinations_data = validated_data.pop('examinations')
        medicals_data = validated_data.pop('medicals')
        patient = Patient.objects.create(**validated_data)
        ClinicalExamination.objects.create(patient=patient, **examinations_data)
        MedicalExamination.objects.create(patient=patient, **medicals_data)
        return patient

    def update(self, instance, validated_data):
       
        examinations_data = validated_data.pop('examinations')
        medicals_data = validated_data.pop('medicals')
        # appointments = validated_data.pop('appointments')
        # treatments = validated_data.pop('treatments')
        # attachments = validated_data.pop('attachments')
        
        # CREATE OR UPDATE EXAMINATIONS AND MEDICALS WITH PATIENT DATA
        examinations, created = ClinicalExamination.objects.get_or_create(patient=instance)
        medicals, created = MedicalExamination.objects.get_or_create(patient=instance)

        instance.name = validated_data.get('name', instance.name)
        # instance.doctor = validated_data.get('doctor', instance.doctor)
        instance.dob = validated_data.get('dob', instance.dob)
        instance.gender = validated_data.get('gender', instance.gender)
        instance.description = validated_data.get('description', instance.description)
        instance.phone = validated_data.get('phone', instance.email)
        instance.email = validated_data.get('email', instance.email)
        instance.status = validated_data.get('status', instance.status)
        print('=== instance.examinations ===')
        print(instance.examinations)
        print('=== instance.examinations ===')

        instance.save()

        examinations.skeletal_class     = examinations_data.get('skeletal_class', examinations.skeletal_class) 
        examinations.nasolabial_angle   = examinations_data.get('nasolabial_angle', examinations.nasolabial_angle)
        examinations.nasolabial_sulcus  = examinations_data.get('nasolabial_sulcus', examinations.nasolabial_sulcus)
        examinations.lip_competency     = examinations_data.get('lip_competency', examinations.lip_competency)
        examinations.face_form          = examinations_data.get('face_form', examinations.face_form)
        examinations.molar_class_left   = examinations_data.get('molar_class_left', examinations.molar_class_left)
        examinations.molar_class_right  = examinations_data.get('molar_class_right', examinations.molar_class_right)
        examinations.midline_upper      = examinations_data.get('midline_upper', examinations.midline_upper)
        examinations.midline_lower      = examinations_data.get('midline_lower', examinations.midline_lower)
        examinations.overjet            = examinations_data.get('overjet', examinations.overjet)
        examinations.oral_hygiene       = examinations_data.get('oral_hygiene', examinations.oral_hygiene)
        examinations.treatment_plan     = examinations_data.get('treatment_plan', examinations.treatment_plan)
        examinations.slot               = examinations_data.get('slot', examinations.slot)
        examinations.treated_arch       = examinations_data.get('treated_arch', examinations.treated_arch) 
        examinations.bracket_system     = examinations_data.get('bracket_system', examinations.bracket_system)
        examinations.extraction_upper   = examinations_data.get('extraction_upper', examinations.extraction_upper)
        examinations.extraction_lower   = examinations_data.get('extraction_lower', examinations.extraction_lower)
        examinations.anchorage_upper    = examinations_data.get('anchorage_upper', examinations.anchorage_upper)

        examinations.save()


        medicals.physical_restrictions  = medicals_data.get('physical_restrictions', medicals.physical_restrictions)
        medicals.sinus_infections               = medicals_data.get('sinus_infections', medicals.sinus_infections)
        medicals.diabetes               = medicals_data.get('diabetes', medicals.diabetes) 
        medicals.heart_problem          = medicals_data.get('heart_problem', medicals.heart_problem)
        medicals.kidney_illness         = medicals_data.get('kidney_illness', medicals.kidney_illness)
        medicals.emotional_difficulties = medicals_data.get('emotional_difficulties', medicals.emotional_difficulties)
        medicals.other_diseasses        = medicals_data.get('other_diseasses', medicals.other_diseasses)

        medicals.save()

        return instance

class PatientPictureSerializer(serializers.ModelSerializer):
    
    class Meta:
        model = Patient
        fields = ("id", "image",)
        read_only_Fields = ('id',)

