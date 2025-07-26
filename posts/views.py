from django.shortcuts import render, redirect
from .models import Post


# Create your views here.
def index(request, *args, **kwargs):
    posts = Post.objects.all()
    return render(request, "index.html", {"posts": posts})


def create(request, *args, **kwargs):
    return render(request, "posts/create.html")


def store(request, *args, **kwargs):

    title = request.POST.get("title")
    content = request.POST.get("content")
    image = request.FILES.get("image")

    if (
        title != ""
        and title is not None
        and content is not None
        and content != ""
    ):
        post = Post(title=title, content=content, image=image)
        post.save()

        return redirect("index")
    else:
        return render(
            request,
            "posts/create.html",
            {
                "messages": {
                    "content": "Please complete all the field. Ps title and content"
                }
            },
        )


def create(request, id, *args, **kwargs):
    post = Post.objects.filter(id=id).get()
    return render(request, "posts/edit.html", {"post": post})


def update(request, *args, **kwargs):
    title = request.POST.get("title")
    id = request.POST.get("id")
    content = request.POST.get("content")
    image = request.FILES.get("image")
    

    if (
        title != ""
        and title is not None
        and content is not None
        and content != ""
    ):
        post = Post.objects.filter(id=id).get()
        post.title = title
        post.content = content
        if image:
            post.image = image
            
        post.save()

        return redirect("index")
    else:
        return render(
            request,
            "posts/create.html",
            {
                "messages": {
                    "content": "Please complete all the field. Ps title and content"
                }
            },
        )


def delete(request, id, *args, **kwargs):
    post = Post.objects.filter(id=id).get()
    post.delete()
    return redirect("index")