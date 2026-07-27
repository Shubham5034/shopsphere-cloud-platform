from .logging_config import logger
from fastapi import APIRouter
from .models.user import User
from fastapi import Depends
from sqlalchemy.orm import Session

from app.database.database import get_db
from app.schemas import UserCreate
from app.schemas import UserCreate, UserUpdate

router = APIRouter()




@router.get("/health")
def health():
    return {
        "status": "UP"
    }

@router.post("/users")
def create_user(user: UserCreate, db: Session = Depends(get_db)):

    logger.info(f"Creating user {user.name}")

    db_user = User(
        name=user.name,
        email=user.email
    )

    db.add(db_user)

    db.commit()

    db.refresh(db_user)

    return db_user


@router.put("/users/{user_id}")
def update_user(
    user_id: int,
    user: UserUpdate,
    db: Session = Depends(get_db)
):

    db_user = db.query(User).filter(User.id == user_id).first()

    if not db_user:
        return {"message": "User not found"}

    db_user.name = user.name
    db_user.email = user.email

    db.commit()
    db.refresh(db_user)

    return db_user


@router.delete("/users/{user_id}")
def delete_user(
    user_id: int,
    db: Session = Depends(get_db)
):

    db_user = db.query(User).filter(User.id == user_id).first()

    if not db_user:
        return {"message": "User not found"}

    db.delete(db_user)

    db.commit()

    return {
        "message": "User deleted successfully"
    }

@router.get("/ready")
def readiness():
    return {
        "status": "READY"
    }


@router.get("/users")
def get_users(db: Session = Depends(get_db)):
    return db.query(User).all()

print("Router has", len(router.routes), "routes")

for r in router.routes:
    print(r.path, r.methods)
