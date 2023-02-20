with

source as (
    select * from {{ source('asaak', 'payments') }}
),

ranked as (
    select
        id,
        loan,
        amount,
        payment_timestamp,
        RANK() over (partition by id order by acquisition_timestamp desc, insert_timestamp desc) as rnk

    from source
),

final as (
    select
        id as payment_id,
        loan as loan_id,
        amount,
        payment_timestamp as payment_date

    from ranked
    where rnk = 1
)

select * from final
    
