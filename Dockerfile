FROM python:3.10-alpine

LABEL maintainer="apotik"
LABEL description="Django application with Python 3.10"

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Create a non-root user
RUN adduser --disabled-password --no-create-home django-user

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apk add --no-cache --virtual .build-deps \
    gcc \
    musl-dev \
    libffi-dev \
    libxml2-dev \
    libxslt-dev \
    && apk add --no-cache \
    libxml2 \
    libxslt \
    curl

# Create and activate virtual environment
RUN python -m venv /py
ENV PATH="/py/bin:$PATH"

# Upgrade pip and install dependencies
COPY requirements.txt requirements.dev.txt ./
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Install dev dependencies if needed
ARG DEV=false
RUN if [ "$DEV" = "true" ]; then \
    pip install --no-cache-dir -r requirements.dev.txt; \
    fi

# Copy project files
COPY --chown=django-user:django-user ./app .

# Clean up
RUN apk del .build-deps && \
    rm -rf /root/.cache /tmp/*

# Switch to non-root user
USER django-user

# Expose port
EXPOSE 8000

# Set healthcheck
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/health/ || exit 1
