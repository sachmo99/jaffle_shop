
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with customer as (

    select * from {{ ref('customers') }}

),
orders as (
    select * from {{ ref('orders') }}

),
customer_amount_avg as (
    select c.customer_id,o.amount,CONCAT(c.first_name,' ',c.last_name) as customer_name,number_of_orders, customer_lifetime_value
    from customer c 
    inner join 
    orders o
    on c.customer_id = o.customer_id
)
select 
    *,(amount*0.3*number_of_orders) as bonus_points 
    from customer_amount_avg


/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
