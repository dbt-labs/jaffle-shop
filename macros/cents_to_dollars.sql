{# A basic example for a project-wide macro to cast a column uniformly #}

{% macro cents_to_dollars(column_name) -%}
    round(cast(({{ column_name }} / 100) as numeric), 2)
{%- endmacro %}
