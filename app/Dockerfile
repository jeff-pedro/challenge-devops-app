FROM python:3
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV DJANGO_SUPERUSER_USERNAME=admin
ENV DJANGO_SUPERUSER_PASSWORD=123
ENV DJANGO_SUPERUSER_EMAIL="admin@admin.com"

WORKDIR /api

COPY . /api/

RUN pip install -r requirements.txt

RUN python manage.py migrate

RUN python manage.py loaddata aluraflix/fixtures/programas_iniciais.json

RUN python manage.py createsuperuser --noinput

ENTRYPOINT python manage.py runserver 0.0.0.0:8000

EXPOSE 8000
