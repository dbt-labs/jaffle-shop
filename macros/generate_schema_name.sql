{% macro generate_schema_name(custom_schema_name, node) %}

    {% set default_schema = target.schema %}

    {# seeds go in a global `raw` schema #}
    {% if node.resource_type == 'seed' %}
        {{ custom_schema_name | trim }}

    {# non-specified schemas go to the default target schema #}
    {% elif custom_schema_name is none %}
        {{ default_schema }}

    {# specified custom schemas go to the default target schema concatenated with the custom_schema_name #}
    {% else %}
        {{ default_schema }}_{{ custom_schema_name | trim }}
    {% endif %}

{% endmacro %}
