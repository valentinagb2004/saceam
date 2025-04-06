from django.shortcuts import render, redirect, get_object_or_404
from .models import Departamento
from .forms import DepartamentoForm

def lista_departamentos(request):
    departamentos = Departamento.objects.all()
    return render(request, 'lista_departamentos.html', {
        'departamentos': departamentos
    })

def agregar_departamento(request):
    if request.method == 'POST':
        form = DepartamentoForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('lista_departamentos')
    else:
        form = DepartamentoForm()
    return render(request, 'agregar_departamento.html', {
        'form': form
    })

def editar_departamento(request, id):
    departamento = get_object_or_404(Departamento, id=id)
    form = DepartamentoForm(request.POST or None, instance=departamento)
    if form.is_valid():
        form.save()
        return redirect('lista_departamentos')
    return render(request, 'editar_departamento.html', {
        'form': form,
        'departamento': departamento
    })

def eliminar_departamento(request, id):
    departamento = get_object_or_404(Departamento, id=id)
    departamento.delete()
    return redirect('lista_departamentos')
