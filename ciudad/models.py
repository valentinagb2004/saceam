from django.db import models
from departamento.models import Departamento
from pais.models import Pais  # 👈 Asegúrate de importar el modelo Pais

class Ciudad(models.Model):
    nombre = models.CharField(max_length=100)
    departamento = models.ForeignKey(Departamento, on_delete=models.CASCADE)
    pais = models.ForeignKey(Pais, on_delete=models.CASCADE)  # 👈 Relación directa con País

    def __str__(self):
        return self.nombre


