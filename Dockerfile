FROM python:3.9-alpine3.18
LABEL maintainer="apotik"

ENV PYTHONUNBUFFERED 1
ENV PYTHONPATH=/app

# Install system dependencies
RUN apk add --no-cache \
    postgresql-client \
    postgresql-dev \
    gcc \
    python3-dev \
    musl-dev \
    libffi-dev \
    zlib-dev \
    jpeg-dev \
    && python -m venv /py \
    && /py/bin/pip install --upgrade pip setuptools wheel

# Copy requirements first to leverage Docker cache
COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt

# Install base requirements
RUN /py/bin/pip install --no-cache-dir -r /tmp/requirements.txt

# Copy app code
COPY ./app /app
WORKDIR /app

EXPOSE 8000

ARG DEV=false
RUN if [ $DEV = "true" ]; \
    then /py/bin/pip install --no-cache-dir -r /tmp/requirements.dev.txt; \
    fi \
    && rm -rf /tmp \
    && adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH="/py/bin:$PATH"

USER django-user