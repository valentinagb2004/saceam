from django.urls import path
from . import views

urlpatterns =[
    path('', views.lista_pais, name='lista_paises'),
    path('agregar/', views.agregar_pais, name='agregar_pais'),
    path('editar/<int:id>/', views.editar_pais, name='editar_pais'),
    path('eliminar/<int:id>/', views.eliminar_pais, name='eliminar_pais'),
]
