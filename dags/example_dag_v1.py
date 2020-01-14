from airflow import DAG
from airflow.operators.python_operator import PythonOperator
from datetime import datetime

dag = DAG(
    "example_dag_v1",
    schedule_interval="0 0 0 * *",
    start_date=datetime(2020, 1, 12, 4, 20, 0),
)

t1 = PythonOperator(
    task_id="example_task",
    python_callable=lambda: print("hello world!"),
    dag=dag,
)
