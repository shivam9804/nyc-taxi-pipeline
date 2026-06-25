
from datetime import datetime
from airflow.sdk import dag
from airflow.providers.google.cloud.operators.dataform import DataformCreateCompilationResultOperator, DataformCreateWorkflowInvocationOperator
from airflow.operators.python import PythonOperator
from include.contract_validator import validate_contract

@dag(
    dag_id="nyc_taxi_pipeline",
    start_date=datetime(2024, 6, 1),
    schedule=None,
)
def nyc_taxi_pipeline():

    validate_silver_contract = PythonOperator(
        task_id="validate_silver_contract",
        python_callable=validate_contract,
        op_kwargs={
            "contract_path": "contracts/silver_yellow_taxi_trips.yaml"
        }
    )

    dataform_create_compilation_result = DataformCreateCompilationResultOperator(
        task_id="dataform_create_compilation_result",
        project_id="data-engineering-496314",
        region="us-central1",
        repository_id="nyc-taxi-pipeline",
        compilation_result={
            "git_commitish": "main",
        }
    )

    dataform_create_silver_workflow_invocation = DataformCreateWorkflowInvocationOperator(
        task_id="dataform_create_silver_workflow_invocation",
        project_id="data-engineering-496314",
        region="us-central1",
        repository_id="nyc-taxi-pipeline",
        workflow_invocation={
            "compilation_result": "{{ task_instance.xcom_pull('dataform_create_compilation_result')['name'] }}",
            "invocation_config": {
                "included_tags": ["silver"],
                "transitive_dependencies_included": True,
                "transitive_dependents_included": False,
                "service_account": "dataform-sa@data-engineering-496314.iam.gserviceaccount.com"
            }
        }
    )

    validate_gold_contract = PythonOperator(
        task_id="validate_gold_contract",
        python_callable=validate_contract,
        op_kwargs={
            "contract_path": "contracts/gold_avg_fare_by_borough.yaml"
        }
    )

    dataform_create_gold_workflow_invocation = DataformCreateWorkflowInvocationOperator(
        task_id="dataform_create_gold_workflow_invocation",
        project_id="data-engineering-496314",
        region="us-central1",
        repository_id="nyc-taxi-pipeline",
        workflow_invocation={
            "compilation_result": "{{ task_instance.xcom_pull('dataform_create_compilation_result')['name'] }}",
            "invocation_config": {
                "included_tags": ["gold"],
                "transitive_dependencies_included": False,
                "transitive_dependents_included": False,
                "service_account": "dataform-sa@data-engineering-496314.iam.gserviceaccount.com"
            }
        }
    )

    validate_silver_contract >>\
        dataform_create_compilation_result >>\
        dataform_create_silver_workflow_invocation >>\
        validate_gold_contract >>\
        dataform_create_gold_workflow_invocation


nyc_taxi_pipeline()
