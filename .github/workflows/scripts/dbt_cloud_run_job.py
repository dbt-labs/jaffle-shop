import os
import time
import requests

# ------------------------------------------------------------------------------
# get environment variables
# ------------------------------------------------------------------------------
api_base = os.getenv(
    "DBT_URL", "https://cloud.getdbt.com"
)  # default to multitenant url
job_cause = os.getenv(
    "DBT_JOB_CAUSE", "API-triggered job"
)  # default to generic message
git_branch = os.getenv("DBT_JOB_BRANCH", None)  # default to None
schema_override = os.getenv("DBT_JOB_SCHEMA_OVERRIDE", None)  # default to None
api_key = os.environ[
    "DBT_API_KEY"
]  # no default here, just throw an error here if key not provided
account_id = os.environ[
    "DBT_ACCOUNT_ID"
]  # no default here, just throw an error here if id not provided
project_id = os.environ[
    "DBT_PROJECT_ID"
]  # no default here, just throw an error here if id not provided
job_id = os.environ[
    "DBT_PR_JOB_ID"
]  # no default here, just throw an error here if id not provided

print(f"""
Configuration:
api_base: {api_base}
job_cause: {job_cause}
git_branch: {git_branch}
schema_override: {schema_override}
account_id: {account_id}
project_id: {project_id}
job_id: {job_id}
""")

req_auth_header = {"Authorization": f"Token {api_key}"}
req_job_url = f"{api_base}/api/v2/accounts/{account_id}/jobs/{job_id}/run/"
run_status_map = {  # dbt run statuses are encoded as integers. This map provides a human-readable status
    1: "Queued",
    2: "Starting",
    3: "Running",
    10: "Success",
    20: "Error",
    30: "Cancelled",
}

type AuthHeader = dict[str, str]


def run_job(
    url: str,
    headers: AuthHeader,
    cause: str,
    branch: str | None = None,
    schema_override: str | None = None,
) -> int:
    """
    Runs a dbt job
    """

    # build payload
    req_payload = {"cause": cause}
    if branch and not branch.startswith(
        "$("
    ):  # starts with '$(' indicates a valid branch name was not provided
        req_payload["git_branch"] = branch.replace("refs/heads/", "")
    if schema_override:
        req_payload["schema_override"] = schema_override.replace("-", "_").replace(
            "/", "_"
        )

    # trigger job
    print(f"Triggering job:\n\turl: {url}\n\tpayload: {req_payload}")

    response = requests.post(url, headers=headers, json=req_payload)
    run_id: int = response.json()["data"]["id"]
    return run_id


def get_run_status(url: str, headers: AuthHeader) -> str:
    """
    gets the status of a running dbt job
    """
    # get status
    response = requests.get(url, headers=headers)
    run_status_code: int = response.json()["data"]["status"]
    run_status = run_status_map[run_status_code]
    return run_status


def main():
    print("Beginning request for job run...")

    # run job
    run_id: int = 0
    try:
        run_id = run_job(
            req_job_url, req_auth_header, job_cause, git_branch, schema_override
        )
    except Exception as e:
        print(f"ERROR! - Could not trigger job:\n {e}")
        raise

    # build status check url and run status link
    req_status_url = f"{api_base}/api/v2/accounts/{account_id}/runs/{run_id}/"
    run_status_link = (
        f"{api_base}/deploy/{account_id}/projects/{project_id}/runs/{run_id}/"
    )

    # update user with status link
    print(f"Job running! See job status at {run_status_link}")

    # check status indefinitely with an initial wait period
    time.sleep(30)
    while True:
        status = get_run_status(req_status_url, req_auth_header)
        print(f"Run status -> {status}")

        if status in ["Error", "Cancelled"]:
            raise Exception(f"Run failed or canceled. See why at {run_status_link}")

        if status == "Success":
            print(f"Job completed successfully! See details at {run_status_link}")
            return

        time.sleep(10)


if __name__ == "__main__":
    main()
