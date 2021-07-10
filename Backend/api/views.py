from rest_framework import generics, permissions
#from django.views import generic
from rest_framework.response import Response
from knox.models import AuthToken
from .serializers import UserSerializer, RegisterSerializer, ArticleSerializer,StockSerializer, UploadSerializer, ChangePasswordSerializer
from django.contrib.auth import login
from rest_framework.authtoken.serializers import AuthTokenSerializer
from knox.views import LoginView as KnoxLoginView
from .models import *
from rest_framework import status
from rest_framework.decorators import api_view
import requests
from rest_framework.parsers import FormParser, MultiPartParser
from django.contrib.auth.models import User
from rest_framework.permissions import IsAuthenticated
from rest_framework import filters

# Register API
class RegisterAPI(generics.GenericAPIView):
    serializer_class = RegisterSerializer

    def post(self, request, *args, **kwargs):
        if request.data['password']==request.data['password2']:
            serializer = self.get_serializer(data=request.data)
            serializer.is_valid(raise_exception=True)
            user = serializer.save()
            return Response({
            "user": UserSerializer(user, context=self.get_serializer_context()).data,
            "token": AuthToken.objects.create(user)[1]
            })
        else:
            return Response({"Failed":"The passwords you provided didn't match."},status=status.HTTP_406_NOT_ACCEPTABLE)

class LoginAPI(KnoxLoginView):
    permission_classes = (permissions.AllowAny,)

    def post(self, request, format=None):
        serializer = AuthTokenSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        login(request, user)
        return super(LoginAPI, self).post(request, format=None)



class ChangePasswordView(generics.UpdateAPIView):
    serializer_class = ChangePasswordSerializer
    model = User
    #permission_classes = (IsAuthenticated,)

    def get_object(self, queryset=None):
        obj = self.request.user
        return obj

    def post(self, request, *args, **kwargs):
        self.object = self.get_object()
        serializer = self.get_serializer(data=request.data)

        if serializer.is_valid():
            # Check old password
            if not self.object.check_password(serializer.data.get("old_password")):
                return Response({"old_password": ["Wrong password."]}, status=status.HTTP_400_BAD_REQUEST)
            # set_password also hashes the password that the user will get
            self.object.set_password(serializer.data.get("new_password"))
            self.object.save()
            response = {
                'status': 'success',
                'code': status.HTTP_200_OK,
                'message': 'Password updated successfully',
                'data': []
            }

            return Response(response)

#Gives List of Articles
class ArticleView(generics.ListAPIView):
    queryset = Article.objects.all()
    serializer_class = ArticleSerializer

    def post(self, request,format=None):
        serializer = ArticleSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

#Gives an Article out of the List of Articles
class ArticleDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Article.objects.all()
    serializer_class = ArticleSerializer

class ArticleSearchView(generics.ListAPIView):
    queryset = Article.objects.all()
    serializer_class = ArticleSerializer
    filter_backends = [filters.SearchFilter]
    search_fields = ['$title']

class StockView(generics.ListAPIView):
    def post(self,request):
        len = StockData.objects.all().count()
        if len==20:
            StockData.objects.all().delete()
        serializer = StockSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def get(self,request):
        stonks = StockData.objects.all()
        serializer = StockSerializer(stonks, many=True)
        return Response(serializer.data)

class NewsView(generics.ListAPIView):
    def get(self,response):
        t = requests.get("https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=7d578c17d9744f0b88c9f2d4e183bae6")
        return Response(t.json())

class CryptoView(generics.ListAPIView):
    def get(self,response):
        headers = {
          'Accepts': 'application/json',
          'X-CMC_PRO_API_KEY': '728a7216-e5b8-4067-8ccc-fe40b9c15789',
        }
        parameters = {
          'start':'1',
          'limit':'10',
          'convert':'INR'
        }

        crypto = requests.get("https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest",params= parameters,headers=headers)

        return Response(crypto.json())


class UploadView(generics.GenericAPIView):
    queryset = Upload.objects.all()
    serializer_class = UploadSerializer
    parser_classes = [MultiPartParser,FormParser]
    def post(self, request,format=None):
        user_id = request.user.id
        request.data['owner'] = user_id
        serializer = UploadSerializer(data=request.data)

        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        else:
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def get(self,request, format=None):
        try:
            profilepic = Upload.objects.get(owner=request.user.id)
            serializer = UploadSerializer(profilepic, many=False)
            return Response(serializer.data)
        except:
            return Response({"image_url":"https://ashish226.pythonanywhere.com/media/images/default.jpg"})


