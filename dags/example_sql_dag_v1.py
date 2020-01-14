from airflow import DAG
from airflow.operators.postgres_operator import PostgresOperator
from datetime import datetime

dag = DAG(
    "example_sql_dag_v1",
    schedule_interval="0 0 0 * *",
    start_date=datetime(2020, 1, 12, 4, 20, 0),
)

t1 = PostgresOperator(
    task_id="example_sql_task",
    sql="""
    SELECT *
      FROM my_table
     WHERE timestamp > '{{ds}}'
    """,
    dag=dag,
)
