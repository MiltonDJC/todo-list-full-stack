"""Service methods that interact with crud"""

from fastapi import HTTPException
from sqlalchemy.orm import Session
from .schemas import TaskCreate, TaskUpdate
from app import crud


def get_specific_task(db: Session, task_id: int):
    """Get specific saved task from service"""
    task_found = crud.get_specific_task(db, task_id)

    if task_found is None:
        raise HTTPException(status_code=404, detail="Task not found")

    return task_found


def get_tasks(db: Session):
    """Get all saved tasks from service"""
    tasks = crud.get_tasks(db)

    return tasks


def create_task(db: Session, task: TaskCreate):
    """Create a new task from service"""
    tasks = crud.get_tasks(db)

    for registered_task in tasks:
        if registered_task.title == task.title:
            raise HTTPException(status_code=409, detail="Task already exists")

    task_to_create = crud.create_task(db, task)

    return task_to_create


def update_task(db: Session, task_id: int, new_task: TaskUpdate):
    """Update an old task from service"""

    task_to_update = crud.get_specific_task(db, task_id)

    if task_to_update is None:
        raise HTTPException(status_code=404, detail="Task not found")

    if new_task.title is None:
        new_task.title = task_to_update.title

    if new_task.completed is None:
        new_task.completed = task_to_update.completed

    task_updated = crud.update_task(db, task_id, new_task)

    return task_updated


def delete_task(db: Session, task_id: int):
    """Delete task from service"""
    task_to_delete = crud.get_specific_task(db, task_id)

    if task_to_delete is None:
        raise HTTPException(status_code=404, detail="Task not found")

    task_to_delete = crud.delete_task(db, task_id)

    return task_to_delete


def delete_tasks(db: Session) -> None:
    """Delete tasks from service"""
    crud.delete_tasks(db)
