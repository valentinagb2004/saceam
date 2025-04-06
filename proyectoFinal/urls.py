
from django.contrib import admin
from django.urls import path, include  # 👈 IMPORTANTE: se agregó include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('persona/', include('persona.urls')),  # 👈 Esto conecta con las URLs de la app persona
    path('', include('persona.urls')),
]

