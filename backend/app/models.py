"""Create tasks table"""

from sqlalchemy import Column, Integer, String, Boolean
from .database import Base

class Task(Base):
    """Task table"""
    __tablename__ = "tasks"

    id = Column(Integer, primary_key=True, index=True)
    title = Column(String, nullable=False)
    completed = Column(Boolean, default=False)
