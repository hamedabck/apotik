# Django DRF Project

A Django REST Framework project with Docker and GitHub Actions CI/CD setup.

## Features

- Django REST Framework
- Docker and Docker Compose
- GitHub Actions CI/CD
- PostgreSQL support via dj-database-url
- SQLite for development and testing

## Getting Started

### Prerequisites

- Docker and Docker Compose
- Git

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/drf-project.git
   cd drf-project
   ```

2. Create a `.env` file based on `.env.example`:
   ```bash
   cp .env.example .env
   ```

3. Build and run the Docker containers:
   ```bash
   docker compose up -d
   ```

4. Access the application at http://localhost:8000

### Development

To run the application in development mode:

```bash
docker compose up
```

### Testing

To run tests:

```bash
docker compose run --rm app python manage.py test
```

### Linting

To run linting:

```bash
docker compose run --rm app flake8
```

## CI/CD

The project uses GitHub Actions for continuous integration. The workflow runs on every push and pull request, performing the following tasks:

- Building the Docker image
- Running tests
- Running linting

## Deployment

For production deployment, set the following environment variables:

- `DEBUG=False`
- `SECRET_KEY=<your-secure-secret-key>`
- `ALLOWED_HOSTS=<your-domain>`
- `DATABASE_URL=<your-database-url>`
- `TARGET=production`

## License

This project is licensed under the MIT License - see the LICENSE file for details.