# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from django.db import models
from django.contrib.auth.models import User

# Create your models here.



class Article(models.Model):
    id = models.BigAutoField(primary_key=True)
    title = models.CharField(max_length=200, unique=True)
    author = models.CharField(max_length=100)
    category = models.CharField(max_length=50)
    image = models.ImageField(upload_to='articleimages/',null=True, blank=True,default='stonks.jpg')
    content = models.TextField()
    created_on = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-created_on']

    def __str__(self):
        return self.title

class StockData(models.Model):
    stock_type = models.CharField(max_length=20)
    name = models.CharField(max_length=20)
    LTP = models.DecimalField(max_digits=10, decimal_places=2)
    change = models.DecimalField(max_digits=10, decimal_places=2)
    pChange = models.DecimalField(max_digits=10, decimal_places=2)

class Upload(models.Model):
    owner = models.OneToOneField(User, on_delete=models.CASCADE)
    image = models.ImageField(upload_to='images/',null=True, blank=True,default='default.jpg')

    def __str__(self):
        return self.owner






