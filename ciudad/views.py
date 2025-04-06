from django.shortcuts import render

# Create your views here.
from django.shortcuts import render, redirect, get_object_or_404
from .models import Ciudad
from .forms import CiudadForm

def lista_ciudades(request):
    ciudades = Ciudad.objects.all()
    return render(request, 'lista_ciudades.html', {'ciudades': ciudades})

def agregar_ciudad(request):
    if request.method == 'POST':
        form = CiudadForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('lista_ciudades')
    else:
        form = CiudadForm()
    return render(request, 'agregar_ciudad.html', {'form': form})

def editar_ciudad(request, id):
    ciudad = get_object_or_404(Ciudad, id=id)
    form = CiudadForm(request.POST or None, instance=ciudad)
    if form.is_valid():
        form.save()
        return redirect('lista_ciudades')
    return render(request, 'editar_ciudad.html', {'form': form, 'ciudad': ciudad})

def eliminar_ciudad(request, id):
    ciudad = get_object_or_404(Ciudad, id=id)
    ciudad.delete()
    return redirect('lista_ciudades')
