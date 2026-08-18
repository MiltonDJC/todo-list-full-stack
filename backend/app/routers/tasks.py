"""Route for creating and getting the tasks from FastAPI"""

from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session

from ..database import SessionLocal
from ..schemas import TaskCreate, TaskUpdate, TaskResponse
from .. import service

router = APIRouter(prefix="/tasks", tags=["Tasks"])


def get_db():
    """Start a db session"""
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.get("/{task_id}", response_model=TaskResponse)
def read_task_route(task_id: int, db: Session = Depends(get_db)):
    """Route for getting specific task"""
    return service.get_specific_task(db, task_id)


@router.get("/", response_model=list[TaskResponse])
def read_tasks_route(db: Session = Depends(get_db)):
    """Route for getting all tasks"""
    return service.get_tasks(db)


@router.post("/", response_model=TaskResponse)
def create_task_route(task: TaskCreate, db: Session = Depends(get_db)):
    """Route for creating new task"""
    return service.create_task(db, task)


@router.put("/{task_id}", response_model=TaskResponse)
def update_task_route(
    task_id: int, task_updated: TaskUpdate, db: Session = Depends(get_db)
):
    """Route for updating specific task"""
    return service.update_task(db, task_id, task_updated)


@router.delete("/{task_id}")
def delete_task_route(task_id: int, db: Session = Depends(get_db)):
    """Route for deleting specific task"""
    return service.delete_task(db, task_id)


@router.delete("/", status_code=204)
def delete_tasks_route(db: Session = Depends(get_db)):
    """Route for deleting all tasks"""
    return service.delete_tasks(db)
