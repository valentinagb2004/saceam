from django.shortcuts import get_object_or_404
from django.shortcuts import render, redirect
from .models import Persona
from .forms import PersonaForm


# Listar personas
def lista_persona(request):
    personas = Persona.objects.all()
    return render(request, 'lista_personas.html', {'personas': personas})



def agregar_persona(request):
    if request.method == 'POST':
        form = PersonaForm(request.POST)
        print("Datos que llegaron del formulario:")
        print(request.POST)
        if form.is_valid():
            form.save()
            return redirect('lista_personas')  
        else:
            print("Errores en el formulario:")
            print(form.errors)  # Esto imprime los errores del formulario
    else:
        form = PersonaForm()
    return render(request, 'formulario_persona.html', {'form': form})


# Editar persona
def editar_persona(request, id):
    persona = get_object_or_404(Persona, id=id)
    if request.method == 'POST':
        form = PersonaForm(request.POST, instance=persona)
        if form.is_valid():
            form.save()
            return redirect('lista_personas')
    else:
        form = PersonaForm(instance=persona)
    return render(request, 'formulario_persona.html', {'form': form})



# Eliminar persona
def eliminar_persona(request, id):
    persona = get_object_or_404(Persona, id=id)
    persona.delete()
    return redirect('lista_personas')
