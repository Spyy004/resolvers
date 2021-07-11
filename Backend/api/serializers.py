from rest_framework import serializers
from django.contrib.auth.models import User
from . import models
from django.core.validators import EmailValidator
from rest_framework.validators import UniqueValidator

# User Serializer
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('id', 'username', 'email')

# Register Serializer
class RegisterSerializer(serializers.ModelSerializer):
    email = serializers.EmailField(
        validators=[UniqueValidator(queryset=User.objects.all())]
    )

    class Meta:
        model = User
        fields = ('id', 'username', 'email', 'password')
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        user = User.objects.create_user(validated_data['username'], validated_data['email'], validated_data['password'])

        return user


class ChangePasswordSerializer(serializers.Serializer):
    model = User

    old_password = serializers.CharField(required=True)
    new_password = serializers.CharField(required=True)

# Article Serializer
class ArticleSerializer(serializers.ModelSerializer):
    image_url = serializers.SerializerMethodField('get_article_photo_url')

    class Meta:
        fields = ('id', 'title','author','category', 'content','image', 'image_url' ,'created_on',)
        model = models.Article

    def get_article_photo_url(self, obj):
        return "https://ashish226.pythonanywhere.com/media/articleimages/"+obj.image.url.split('/')[-1]


class StockSerializer(serializers.ModelSerializer):

    class Meta:
        fields = ('stock_type','name','LTP','change','pChange',)
        model = models.StockData


class UserFormSerializer(serializers.ModelSerializer):

    class Meta:
        fields = ('id','name','email','education_details','linkedin_url','add_info')
        model = models.UserForm

class UploadSerializer(serializers.ModelSerializer):
    owner = serializers.PrimaryKeyRelatedField(queryset=User.objects.all())
    image_url = serializers.SerializerMethodField('get_photo_url')

    class Meta:
        fields = ('owner','image','image_url')
        model = models.Upload

    def get_photo_url(self, obj):
        return "https://ashish226.pythonanywhere.com/media/images/"+obj.image.url.split('/')[-1]
