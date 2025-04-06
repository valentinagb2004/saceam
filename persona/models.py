 
from django.db import models
from ciudad.models import Ciudad

class Persona(models.Model):
    nombre = models.CharField(max_length=100)
    apellido = models.CharField(max_length=100)
    fecha_nacimiento = models.DateField()
    estrato = models.IntegerField()
    sisben = models.CharField(max_length=50)

    ciudad_nacimiento = models.ForeignKey(
        Ciudad, related_name='nacidos_en', on_delete=models.SET_NULL, null=True, blank=True
    )

    ciudad_residencia = models.ForeignKey(
        Ciudad, related_name='residentes_en', on_delete=models.SET_NULL, null=True, blank=True
    )

    def __str__(self):
        return f"{self.nombre} {self.apellido}"
    