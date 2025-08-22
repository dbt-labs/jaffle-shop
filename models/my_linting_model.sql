with cte_example as (
    select
        a.column1,
        b.column2,
        a.column3
    from
        schema.table_a as a
    join
        schema.table_b as b
        on a.id = b.id
    where
        a.condition = 'value'
)

select
    cte_example.column1,
    cte_example.column2,
    cte_example.column3
from
    cte_example
order by
    cte_example.column1 desc
