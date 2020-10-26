from django.contrib.auth import get_user_model, authenticate
from rest_framework import serializers
from core.models import Patient, Attachment, Doctor, Treatment

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



class AttachmentSerializer(serializers.ModelSerializer):
    # Serializer for uploading images for recipes

    class Meta:
        model = Attachment
        fields = ('id', 'filename', 'file')
        read_only_Fields = ('id',)

    def create(self, validated_data):

        file = Attachment(
            file=validated_data['file'], 
            filename=validated_data['filename']
            )
        file.save()

        # print('==|==|==')
        # print(validated_data['file'])
        # print('==|==|==')

        return file





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
            'id', 'user', 'patient', 'title', 'description', 'files', 'created'         
        ]
        read_only_Fields = ('id',)

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
            'id', 'user', 'patient', 'title', 'description', 'files', 'created'         
        ]
        read_only_Fields = ('id',)
    


class PatientSerializer(serializers.ModelSerializer):
   
    treatments = TreatmentSerializer(many=True, required=False)

    class Meta:
        model = Patient
        fields = [
            'id', 'user', 'name', 'doctor', 'dob', 'gender', 'description', 'phone',
            'email', 'treatments', 'status' 
         
        ]
        read_only_Fields = ('id',)

