from rest_framework import serializers
from core.models import Patient, Attachment



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

        print('==|==|==')
        print(validated_data['file'])
        print('==|==|==')

        return file

class PatientSerializer(serializers.ModelSerializer):
    # Serializer for uploading images for recipes

    class Meta:
        model = Patient
        fields = [
            'id', 'name', 'doctor', 'dob', 'gender', 'description', 'address', 'phone',
            'email', 'status' 
         
        ]
        read_only_Fields = ('id',)
