"""Tasks's schemas"""

from typing import Optional
from pydantic import BaseModel


class TaskCreate(BaseModel):
    """Schema for creating task"""

    title: str


class TaskUpdate(BaseModel):
    """Schema for updating task"""

    title: Optional[str] = None
    completed: Optional[bool] = None


class TaskResponse(BaseModel):
    """Schema for returning task"""

    id: int
    title: str
    completed: bool

    class Config:
        """Allow creating schemas from ORM objects"""

        orm_mode = True
