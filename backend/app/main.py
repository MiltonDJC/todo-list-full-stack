from fastapi import FastAPI
from .database import engine, Base
from .routers import tasks

Base.metadata.create_all(bind=engine)

app = FastAPI()

app.include_router(tasks.router)


@app.get("/")
def root():
    return {"status": "ok", "version": "1.0.0", "message": "API funcionando"}
