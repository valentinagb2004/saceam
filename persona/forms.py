from django import forms
from .models import Persona

class personaForm(forms.ModelForm):
    class Meta:
        model = Persona
        fields = ['nombre', 'apellido', 'fecha_nacimiento', 'ciudad_id_nacimiento', 'ciudad_id_residencia', 'estrato', 'sisben']
