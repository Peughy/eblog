from django.shortcuts import render


# Create your views here.
def index(request, *args, **kwargs):
    return render(request, "index.html")


def create(request, *args, **kwargs):
    return render(request, "posts/create.html", {"post": {}})
