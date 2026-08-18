"""Conection with database"""

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, DeclarativeBase

# Todo: Utilizar variables de entorno para no almacer aquí los datos de conexión a la BD

DATABASE_URL = "postgresql+psycopg2://postgres:maxpsql@localhost:5432/todo_db"

engine = create_engine(DATABASE_URL)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)


class Base(DeclarativeBase):
    pass
