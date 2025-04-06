from django.contrib import admin
from .models import Persona

# Register your models here.
@admin.register(Persona)
class personaAdmin(admin.ModelAdmin):
    list_display = ('nombre', 'apellido', 'fecha_nacimiento', 'ciudad_id_nacimiento', 'ciudad_id_residencia', 'estrato', 'sisben')
