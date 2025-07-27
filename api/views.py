from django.http import JsonResponse
from posts import models


# Create your views here.
def index(request, *args, **kwargs):
    post = models.Post.objects.all().values("id", "title", "content", "image")
    post = list(post)
    return JsonResponse(post, safe=False)
