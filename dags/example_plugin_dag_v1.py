from airflow import DAG
from airflow.operators.example_operator import ExampleOperator
from datetime import datetime

dag = DAG(
    "example_plugin_dag_v1",
    schedule_interval="0 0 0 * *",
    start_date=datetime(2020, 1, 12, 4, 20, 0),
)

t1 = ExampleOperator(
    task_id="example_task",
    python_callable=lambda: print("(hello inner!)"),
    dag=dag,
)
