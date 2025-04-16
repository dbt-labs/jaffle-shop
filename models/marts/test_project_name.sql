-- models/test_project_name.sql

{{ config(materialized='table') }}

{{ test_project_name_macro() }}

select 1 as dummy_column
