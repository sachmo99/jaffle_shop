select * from {{ ref('customers') }} c1 where 2-1 = (select count(distinct number_of_orders) from {{ ref('customers')}} c2 where c2.number_of_orders > c1.number_of_orders)