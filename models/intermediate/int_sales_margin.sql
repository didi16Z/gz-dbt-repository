

with s as (
  select * from {{ ref('stg_gz_raw_data__raw_gz_sales') }}
),
p as (
  select * from {{ ref('stg_gz_raw_data__raw_gz_product') }}
)

select
  s.orders_id,s.date_date,
  s.products_id,
  s.quantity,
  s.revenue,
  p.purchase_price,
  s.quantity * p.purchase_price        as purchase_cost,
  s.revenue - (s.quantity * p.purchase_price) as margin
from s
left join p
  on s.products_id = p.products_id
