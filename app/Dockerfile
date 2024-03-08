FROM alpine:3.16.0
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

ENV DJANGO_SUPERUSER_PASSWORD=admin
ENV DJANGO_SUPERUSER_EMAIL=admn@aluraflix.com
ENV DJANGO_SUPERUSER_USERNAME=admin

WORKDIR /api

RUN set -xe

COPY . /api/

RUN apk add --no-cache python3 py3-pip tini; \
    pip install --upgrade pip setuptools-scm; \
    pip install --no-cache-dir --ignore-installed -r requirements.txt

RUN sed -i 's/ALLOWED_HOSTS = \[\]/ALLOWED_HOSTS = \["*"\]/g' setup/settings.py

RUN python3 manage.py migrate --noinput; \
    python3 manage.py createsuperuser --noinput; \
    python3 manage.py loaddata aluraflix/fixtures/programas_iniciais.json

EXPOSE 80/tcp
ENTRYPOINT [ "tini", "--" ]
CMD [ "python3", "manage.py", "runserver", "0.0.0.0:80" ]
