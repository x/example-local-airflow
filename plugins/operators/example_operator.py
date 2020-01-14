from airflow.operators import BaseOperator
from airflow.operators.python_operator import PythonOperator
from airflow.plugins_manager import AirflowPlugin
from airflow.utils.decorators import apply_defaults


class ExampleOperator(PythonOperator):
    @apply_defaults
    def __init__(self, python_callable=None, **kwargs):
        def _new_callable():
            print("hello")
            python_callable()
            print("outer!")
        super(ExampleOperator, self).__init__(python_callable=_new_callable, **kwargs)


class ExampleOperatorPlugin(AirflowPlugin):
    name = "example_operator"
    operators = [ExampleOperator]
