{# A basic example for a project-wide macro to cast a column uniformly #}

{% macro cents_to_dollars(column_name) -%}
    {{ return(adapter.dispatch('cents_to_dollars')(column_name)) }}
{%- endmacro %}

{% macro default__cents_to_dollars(column_name) -%}
    ({{ column_name }} / 100)::numeric(16, 2)
{%- endmacro %}

{% macro postgres__cents_to_dollars(column_name) -%}
    ({{ column_name }}::numeric(16, 2) / 100)
{%- endmacro %}

{% macro bigquery__cents_to_dollars(column_name) %}
    round(cast(({{ column_name }} / 100) as numeric), 2)
{% endmacro %}

{% macro fabric__cents_to_dollars(column_name) %}
    cast({{ column_name }} / 100 as numeric(16,2))
{% endmacro %}

{#
  ClickHouse: Int64 / Int64 promotes to Float64 before the ::numeric cast.
  e.g. 1908 / 100 = 19.0799999... in Float64, which truncates to 19.07 instead of 19.08.
  Fix: use intDiv + modulo to stay in integer arithmetic, then build the decimal string.
  See: https://github.com/ClickHouse/jaffle-shop-clickhouse
#}
{% macro clickhouse__cents_to_dollars(column_name) %}
    toDecimal64(
        concat(
            toString(intDiv({{ column_name }}, 100)),
            '.',
            leftPad(toString({{ column_name }} % 100), 2, '0')
        ),
        2
    )
{% endmacro %}
