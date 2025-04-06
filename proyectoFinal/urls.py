
from django.contrib import admin
from django.urls import path, include  # 👈 IMPORTANTE: se agregó include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('persona.urls')),        # Esto es lo que hace que al ir a / cargue persona
    path('pais/', include('pais.urls')),      # Esto hará que al ir a /pais/ cargue lo de pais
    path('departamento/', include('departamento.urls')),
    path('ciudad/', include('ciudad.urls')),


]

