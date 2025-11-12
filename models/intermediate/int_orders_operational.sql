

with o as (
  select *
  from {{ ref('int_orders_margin') }}
),
s as (
  select
    orders_id,
    shipping_fee,
    logcost,
    ship_cost
  from {{ ref('stg_gz_raw_data__raw_gz_ship') }}
)

select
  o.orders_id,
  o.date_date,
  o.revenue,
  o.quantity,
  o.purchase_cost,
  o.margin,
  s.shipping_fee,
  s.logcost,
  s.ship_cost,
  -- Calcul du Operational Margin
  o.margin + s.shipping_fee - s.logcost - s.ship_cost as operational_margin
from  o
left join  s
  on o.orders_id = s.orders_id
order by o.orders_id desc
