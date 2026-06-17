
from datetime import datetime
from airflow.sdk import dag
from airflow.providers.google.cloud.operators.dataform import DataformCreateCompilationResultOperator, DataformCreateWorkflowInvocationOperator

@dag(
    dag_id="nyc_taxi_pipeline",
    start_date=datetime(2024, 6, 1),
    schedule=None,
)
def nyc_taxi_pipeline():
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

    dataform_create_compilation_result >>\
        dataform_create_silver_workflow_invocation >>\
        dataform_create_gold_workflow_invocation


nyc_taxi_pipeline()
