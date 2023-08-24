from django.db import models


# Create your models here.

class User(models.Model):
    # int id primary key auto_increment
    id = models.AutoField(primary_key=True)
    # varchar username(255)
    username = models.CharField(max_length=255)
    password = models.CharField(max_length=255)


class Record(models.Model):
    session_id = models.CharField(max_length=255)
    env = models.CharField(max_length=255)
    status = models.CharField(max_length=255)
    crete_time_before = models.CharField(max_length=255)
    crete_time_after = models.CharField(max_length=255)
    submit_time = models.CharField(max_length=255)