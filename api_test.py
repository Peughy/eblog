import requests

base_url = "http://127.0.0.1:8000/api/"

try:
    response = requests.get(base_url)
    print(response.text)
except Exception:
    print(f"The exception is {Exception}")
