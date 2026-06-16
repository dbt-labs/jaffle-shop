---
name: example-project-skill
description: Use for project-specific conventions, naming rules, and validation steps.
---

# Example project skill

## When to use

Use this skill when working in this repository and you need to follow local conventions that are not covered by the built-in dbt skills.

## What to check first

1. Read `dbt_project.yml` for configured paths and model defaults.
2. Read the target model or YAML before editing.
3. Check nearby files for naming and layering conventions.

## Project conventions

Document repo-specific rules here. For example:

- staging models live under `models/staging`
- marts should use business-friendly column names
- all primary keys get `not_null` and `unique` data tests
- renamed columns should keep a short comment in YAML descriptions when ambiguity is likely

## Workflow

1. Inspect the model and its upstream or downstream dependencies.
2. Make the smallest clean change that fits existing patterns.
3. Validate with the lightest useful dbt command.
4. Summarize what changed and any follow-up work.

## Validation

- SQL model changes: `dbt build --select <model_name>+`
- YAML-only structural changes: `dbt parse`
- Description-only edits: no dbt command needed

## Notes

Add supporting files next to this one if the skill needs examples, reusable SQL patterns, or a checklist.
