"""Crud methods that interact with db"""

from sqlalchemy import text
from sqlalchemy.orm import Session
from .models import Task
from .schemas import TaskCreate, TaskUpdate


def get_specific_task(db: Session, task_id: int):
    """Get specific saved task from crud"""
    return db.query(Task).filter(Task.id == task_id).first()


def get_tasks(db: Session):
    """Get all saved tasks from crud"""
    return db.query(Task).all()


def create_task(db: Session, task: TaskCreate):
    """Create a new task from crud"""
    new_task = Task(title=task.title)
    db.add(new_task)
    db.commit()
    db.refresh(new_task)
    return new_task


def update_task(db: Session, task_id: int, task_updated: TaskUpdate):
    """Update an old task from crud"""
    task_to_update = db.query(Task).filter(Task.id == task_id).first()
    task_to_update.title = task_updated.title
    task_to_update.completed = task_updated.completed

    db.commit()
    db.refresh(task_to_update)

    return task_to_update


def delete_task(db: Session, task_id: int):
    """Delete task from crud"""
    task_to_delete = db.query(Task).filter(Task.id == task_id).first()
    db.delete(task_to_delete)
    db.commit()

    return task_to_delete


def delete_tasks(db: Session) -> None:
    """Delete all tasks from crud"""
    db.execute(text("TRUNCATE TABLE tasks RESTART IDENTITY"))
    db.commit()
