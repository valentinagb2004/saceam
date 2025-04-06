from django.db import models

# Create your models here.
class Persona(models.Model):
    nombre = models.CharField(max_length=100)
    apellido = models.CharField(max_length=100)
    fecha_nacimiento = models.DateField()
    ciudad_id_nacimiento = models.IntegerField()
    ciudad_id_residencia = models.IntegerField()
    estrato = models.IntegerField()
    sisben = models.CharField(max_length=50)

    def __str__ (self):
        return f"{self.id} - {self.nombre} {self.apellido}"