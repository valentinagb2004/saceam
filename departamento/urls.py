from django.urls import path
from . import views

urlpatterns = [
    path('', views.lista_departamentos, name='lista_departamentos'),
    path('agregar/', views.agregar_departamento, name='agregar_departamento'),
    path('editar/<int:id>/', views.editar_departamento, name='editar_departamento'),
    path('eliminar/<int:id>/', views.eliminar_departamento, name='eliminar_departamento'),
]
