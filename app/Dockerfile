# FROM python:3
FROM alpine:3.16.0
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /api

RUN set -xe

COPY . /api/

RUN apk add --no-cache python3 py3-pip tini

RUN pip install --upgrade pip setuptools-scm
    
RUN pip install --no-cache-dir -r requirements.txt

RUN python3 manage.py makemigrations

RUN python3 manage.py migrate

RUN python3 manage.py loaddata aluraflix/fixtures/programas_iniciais.json

RUN addgroup -g 1000 appuser; \
    adduser -u 1000 -G appuser -D -h /app appuser; \
    chown -R appuser:appuser /app

# RUN python3 manage.py createsuperuser --noinput

USER appuser
EXPOSE 8000/tcp
ENTRYPOINT [ "tini", "--" ]
CMD [ "python3", "manage.py", "runserver", "0.0.0.0:8000" ]
