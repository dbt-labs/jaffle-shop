{% macro generate_schema_name(custom_schema_name=none, node=none) -%}
  {%- set default_schema = target.schema -%}
  {%- if custom_schema_name is none and target.name in ('prod') -%}
        {# Check if the model does not contain a subfolder (e.g, models created at the MODELS root folder) #}
        {% if node.fqn[1:-1]|length == 0 %}
            {{ default_schema }}    
        {% else %}
            {# Concat the subfolder(s) name #}
            {% set prefix = node.fqn[1:-1]|join('_') %}
            {{ prefix | trim }}
        {% endif %}

    {%- elif custom_schema_name is not none -%}

        {{ custom_schema_name | trim }}

    {%- else -%}

        {{ target.schema | trim }}

    {%- endif -%}

{%- endmacro %}