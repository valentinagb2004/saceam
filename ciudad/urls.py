from django.urls import path
from . import views

urlpatterns = [
    path('', views.lista_ciudades, name='lista_ciudades'),
    path('agregar/', views.agregar_ciudad, name='agregar_ciudad'),
    path('editar/<int:id>/', views.editar_ciudad, name='editar_ciudad'),
    path('eliminar/<int:id>/', views.eliminar_ciudad, name='eliminar_ciudad'),
]
