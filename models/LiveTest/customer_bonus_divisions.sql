
-- Use the `ref` function to select from other models
{{
    config(
        materialized='view'
    )
}}
with customer_bonus_points as (
    select * from {{ ref('customer_bonus_points') }}
)
{% set bonus_methods_query %}
select * from {{ ref('bonus_methods')}}
{% endset %}
{% set results = run_query(bonus_methods_query) %}
{% if execute %}
{% set list = results.columns[0].values() %}
{% else %}
{% set list = [] %}
{% endif %}
select customer_id,bonus_points,
    {% for ele in list %}
        CAST(bonus_points*customer_lifetime_value/{{results | length }} as NUMERIC(10,3)) as {{ele}}_quota
        {% if not loop.last %},{% endif %}
    {% endfor %}
 from customer_bonus_points

