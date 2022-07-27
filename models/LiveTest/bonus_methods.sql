{{
    config(
        materialized='table'
    )
}}
select
'gift' as bonus_method
union all
select 
'discount' as bonus_method
union all
select
'lucky_draw' as bonus_method
union all
select 
'coupons' as bonus_method
