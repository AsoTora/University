import psycopg2
from contextlib import closing

command="""
CREATE TABLE TEST (
    ID SERIAL PRIMARY KEY,
    NAME VARCHAR(255) NOT NULL
)
"""

with closing(psycopg2.connect(
        host="localhost",
        port=5432,
        user="postgres",
        password="postgres")
    ) as conn:
    with conn.cursor() as cursor:
        cursor.execute(command)
        cursor.execute("INSERT INTO TEST VALUES ('1', 'Banan'), (2, 'Comedy')")
        cursor.execute('SELECT * FROM TEST')
        for row in cursor:
            print(row)