import os
import dj_database_url
from pathlib import Path

def get_database_config():
    """
    Get database configuration from environment variables.
    Supports both DATABASE_URL and individual PostgreSQL settings.
    """
    # Check if DATABASE_URL is set
    database_url = os.getenv('DATABASE_URL')
    
    if database_url:
        # Use dj_database_url to parse the DATABASE_URL
        return dj_database_url.config(
            default=database_url,
            conn_max_age=600
        )
    else:
        # Use SQLite as default
        return {
            'ENGINE': 'django.db.backends.sqlite3',
            'NAME': Path(__file__).resolve().parent.parent.parent / 'db.sqlite3',
        } 