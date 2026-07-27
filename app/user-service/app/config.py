import os
from dotenv import load_dotenv

load_dotenv()


class Settings:

    APP_NAME = os.getenv("APP_NAME")
    APP_ENV = os.getenv("APP_ENV")
    APP_VERSION = os.getenv("APP_VERSION")

    HOST = os.getenv("HOST")
    PORT = int(os.getenv("PORT", 8000))

    DATABASE_HOST = os.getenv("DATABASE_HOST")
    DATABASE_PORT = os.getenv("DATABASE_PORT")
    DATABASE_NAME = os.getenv("DATABASE_NAME")
    DATABASE_USER = os.getenv("DATABASE_USER")
    DATABASE_PASSWORD = os.getenv("DATABASE_PASSWORD")

    LOG_LEVEL = os.getenv("LOG_LEVEL", "INFO")


settings = Settings()
