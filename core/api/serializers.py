from rest_framework import serializers
from core.models import Attachment



class AttachmentSerializer(serializers.ModelSerializer):
    # Serializer for uploading images for recipes

    class Meta:
        model = Attachment
        fields = ('id', 'file')
        read_only_Fields = ('id',)

    def create(self, validated_data):

        file = Attachment(file=validated_data['file'])
        file.save()

        print('==|==|==')
        print(validated_data['file'])
        print('==|==|==')

        return file