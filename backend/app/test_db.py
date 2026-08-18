"""Testing database connection"""

from database import engine
from sqlalchemy import text

try:
    with engine.connect() as connection:
        resutl = connection.execute(text("SELECT 1"))
        print("Conexión exitosa")
        print(resutl.fetchone)
except Exception as e:
    print("Error de conexión")
    print(e)
