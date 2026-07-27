import os

print("=" * 60)
print("MAIN FILE:", __file__)
print("CURRENT DIRECTORY:", os.getcwd())
print("=" * 60)

from fastapi import FastAPI

from app.database.database import Base
from app.database.database import engine

from app.models.user import User

from .config import settings
from .routes import router
from .logging_config import logger


app = FastAPI(
    title=settings.APP_NAME,
    version=settings.APP_VERSION
)

Base.metadata.create_all(bind=engine)

logger.info("Starting User Service")

app.include_router(router)

for route in app.routes:
    try:
        print(route.path, route.methods)
    except AttributeError:
        pass
