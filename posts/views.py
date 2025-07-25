from django.shortcuts import render
from .models import Post


# Create your views here.
def index(request, *args, **kwargs):
    posts = Post.objects.all()
    return render(request, "index.html", {"posts": posts})


def create(request, *args, **kwargs):
    return render(request, "posts/create.html", {"post": {}})
