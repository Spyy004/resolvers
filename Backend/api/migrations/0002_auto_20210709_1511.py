# Generated by Django 2.2.7 on 2021-07-09 09:41

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0001_initial'),
    ]

    operations = [
        migrations.RenameField(
            model_name='article',
            old_name='image_url',
            new_name='image',
        ),
    ]
