from django import forms
from persona.models import Persona
from ciudad.models import Ciudad

class PersonaForm(forms.ModelForm):
    class Meta:
        model = Persona
        fields = '__all__'
    
    def __init__(self, *args, **kwargs):
        super(PersonaForm, self).__init__(*args, **kwargs)
        self.fields['ciudad_nacimiento'].queryset = Ciudad.objects.all()
        self.fields['ciudad_residencia'].queryset = Ciudad.objects.all()
