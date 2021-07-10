from .views import RegisterAPI
from django.urls import path, include
from knox import views as knox_views
from .views import LoginAPI
from . import views
from django.conf import settings
from django.conf.urls.static import static
from django.conf.urls import url

app_name = 'api'
urlpatterns = [
    path('register/', RegisterAPI.as_view(), name='register'),
    path('login/', LoginAPI.as_view(), name='login'),
    path('logout/', knox_views.LogoutView.as_view(), name='logout'),
    path('logoutall/', knox_views.LogoutAllView.as_view(), name='logoutall'),
    path('change-password/', views.ChangePasswordView.as_view(), name='change-password'),
    path('article/', views.ArticleView.as_view(),name='article'),
    path('article/<int:pk>/', views.ArticleDetail.as_view(), name='article-id'),
    path('article-search/',views.ArticleSearchView.as_view(), name='search'),
    path('stock/', views.StockView.as_view(),name='stock'),
    path('crypto/',views.CryptoView.as_view(),name='crypto'),
    path('news/', views.NewsView.as_view(),name='news'),
    path('profile-pic/', views.UploadView.as_view(), name='profile-pic'),
]

