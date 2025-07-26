from django.urls import path
from . import views

urlpatterns = [
    path("", views.index, name="index"),
    path("create/", views.create, name="create"),
    path("store/", views.store),
    path("<int:id>/edit/", views.create, name="edit"),
    path("update/", views.update),
    path("<int:id>/delete/", views.delete, name="delete"),
]

