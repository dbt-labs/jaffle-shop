-- macros/test_project_name.sql

{% macro test_project_name_macro() %}
  {% if project_name == 'jaffle_shop' %}
    {{ log("✅ project_name is jaffle_shop", info=True) }}
  {% else %}
    {{ log("❌ project_name is something else: " ~ project_name, info=True) }}
  {% endif %}
{% endmacro %}
