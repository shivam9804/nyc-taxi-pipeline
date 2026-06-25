import argparse
import yaml

REQUIRED_FIELDS = [
    "dataset",
    "table",
    "owner",
    "tier",
    "tags",
    "sla",
    "columns",
    "quality_rules"
]

SLA_FIELDS = [
    "freshness_hours",
    "row_count"
]

VALID_TYPES = [
    "INTEGER",
    "FLOAT",
    "STRING",
    "TIMESTAMP"
]


def validate_contract(contract_path: str) -> bool:

    with open(contract_path) as f:
        yaml_data = yaml.safe_load(f)

        keys = yaml_data.keys()

        # check all required keys are present
        for key in REQUIRED_FIELDS:
            if key not in keys:
                raise ValueError(f"Missing required field: {key}")

        for key in SLA_FIELDS:
            if key not in yaml_data["sla"].keys():
                raise ValueError(f"Missing SLA field: {key}")

        # check if column types are valid
        for column in yaml_data["columns"].keys():
            if yaml_data["columns"][column]["type"] not in VALID_TYPES:
                raise ValueError(f"Invalid column type: {yaml_data['columns'][column]['type']}")

        print(f"Contract {yaml_data['table']} validation passed")

    return True


def generate_sql_condition(rule: dict) -> str:

    column_name = rule["column"]
    rule_type = rule["rule"]
    value = rule["value"] if "value" in rule else None

    if rule_type == "not_null":
        return f"{column_name} IS NULL"
    elif rule_type == "min_value":
        return f"{column_name} < {value}"
    elif rule_type == "max_value":
        return f"{column_name} > {value}"
    else:
        raise ValueError(f"Invalid rule type: {rule_type}")


def generate_sqlx_assertions(rule: dict, dataset: str, table: str, tags: str) -> str:

    sql_conditions = generate_sql_condition(rule)

    return f"""config {{
    type: "assertion",
    tags: ["{tags}"]
}}

SELECT * FROM ${{ref("{dataset}","{table}")}}
WHERE {sql_conditions}
"""


def emit_assertions(contract_path: str, output_dir: str) -> None:
    with open(contract_path) as f:
        yaml_data = yaml.safe_load(f)

    rules = yaml_data["quality_rules"]
    dataset = yaml_data["dataset"]
    table = yaml_data["table"]
    tags = yaml_data["tier"]

    for rule in rules:
        sqlx = generate_sqlx_assertions(rule, dataset, table, tags)
        column_part = rule.get("column", "table")
        filename = f"assert_{table}_{rule['rule']}_{column_part}.sqlx"
        with open(f"{output_dir}/{filename}", "w") as f:
            f.write(sqlx)
        print(f"Generated: {filename}")


if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument("--contract_path", type=str, help="Path to the contract file")
    parser.add_argument("--output_dir", type=str, default="../definitions/assertions")
    args = parser.parse_args()

    validate_contract(args.contract_path)
    emit_assertions(args.contract_path, args.output_dir)
