from django.shortcuts import render, redirect, get_object_or_404
from .models import Pais
from .forms import PaisForm



def lista_pais(request):
    paises = Pais.objects.all()
    return render(request, 'lista_paises.html', {'paises': paises})

def agregar_pais(request):
    if request.method == 'POST':
        form = PaisForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('lista_paises')
    else:
        form = PaisForm()
    return render(request, 'formulario_pais.html', {'form': form})

def editar_pais(request, id):
    pais = get_object_or_404(Pais, id=id)
    if request.method == 'POST':
        form = PaisForm(request.POST, instance=pais)
        if form.is_valid():
            form.save()
            return redirect('lista_paises')
    else:
        form = PaisForm(instance=pais)
    return render(request, 'formulario_pais.html', {'form': form})

def eliminar_pais(request, id):
    pais = get_object_or_404(Pais, id=id)
    pais.delete()
    return redirect('lista_paises')
