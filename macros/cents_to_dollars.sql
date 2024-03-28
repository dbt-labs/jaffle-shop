{# A basic example for a project-wide macro to cast a column uniformly #}

{% macro cents_to_dollars(column_name, precision=2) -%}
    (cast({{ column_name }} / 100) as numeric(16, {{ precision }})
{%- endmacro %}
