{{ config(materialized=table) }}

with ops as (
  -- one row per order with operational_margin & costs
  select *
  from {{ ref('int_orders_operational') }}
)

select
  date_date,

  -- transactions = number of orders that day
  count(distinct orders_id)                      as total_transactions,

  -- totals
  sum(revenue)                                   as total_revenue,
  sum(purchase_cost)                             as total_purchase_cost,
  sum(shipping_fee)                              as total_shipping_fees,
  sum(logcost)                                   as total_log_costs,
  sum(quantity)                                  as total_quantity_sold,
  sum(operational_margin)                        as operational_margin,

  -- average basket (revenue per order)
  (sum(revenue) / count(distinct orders_id))     as average_basket
from ops
group by date_date
order by date_date
