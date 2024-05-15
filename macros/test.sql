{% macro create_table_snowflake() %}
    {{ run_query("use database ANALYTICS_DEV")}}
    {{run_query("use schema DBT_CHENYU_TEST_1")}}
    {% for i in range(1001, 100000) %}
        {{print(i)}}
        {{ run_query("CREATE OR REPLACE TABLE table_" + (i+1)|string + " (id INT);" ) }} 
    {% endfor %}
{% endmacro %}


{% macro print_table_count_snowflake() %}
    {{ run_query("use database ANALYTICS_DEV")}}
    {{run_query("use schema DBT_CHENYU_TEST_1")}}
    {%set results = run_query("show tables;" )%}

    {{ print(len(results.columns[1].values())) }}
{% endmacro %}


{% macro create_table_p() %}
    {% for i in range(1,10) %}
        {% for j in range(100000) %}
            {{print(i*100000 + j)}}
            {{ run_query("CREATE TABLE IF NOT EXISTS table_" + (i*100000 + j + 1)|string + " (id INT);" ) }} 
        {% endfor %}
    {% endfor %}
{% endmacro %}


{% macro print_table_count_p() %}
    {# {{ run_query("use database postgres")}}
    {{run_query("use schema toy_chenyu")}} #}
    {%set results = run_query("SELECT * FROM pg_catalog.pg_tables;" )%}

    {{ print(len(results.columns[1].values())) }}
{% endmacro %}