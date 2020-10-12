from rest_framework import serializers
from core.models import Attachment



class AttachmentSerializer(serializers.ModelSerializer):
    # Serializer for uploading images for recipes

    class Meta:
        model = Attachment
        fields = ('id', 'file')
        read_only_Fields = ('id',)