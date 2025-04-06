from django.shortcuts import get_object_or_404
from django.shortcuts import render, redirect
from .models import Persona
from .forms import personaForm


# Listar personas
def lista_persona(request):
    personas = Persona.objects.all()
    return render(request, 'lista_personas.html', {'personas': personas})



def agregar_persona(request):
    if request.method == 'POST':
        form = personaForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('lista_personas')  
        else:
            print(form.errors)  # 👈 Esto te muestra en la terminal qué campo está fallando
    else:
        form = personaForm()
    return render(request, 'formulario_persona.html', {'form': form})


# Editar persona
def editar_persona(request, id):
    persona = get_object_or_404(Persona, id=id)
    if request.method == 'POST':
        form = personaForm(request.POST, instance=persona)
        if form.is_valid():
            form.save()
            return redirect('lista_personas')
    else:
        form = personaForm(instance=persona)
    return render(request, 'formulario_persona.html', {'form': form})



# Eliminar persona
def eliminar_persona(request, id):
    persona = get_object_or_404(Persona, id=id)
    persona.delete()
    return redirect('lista_personas')
