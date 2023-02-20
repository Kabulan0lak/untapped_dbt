with

source as (
    select * from {{ source('asaak', 'installments') }}
),

ranked as (

    select
        id,
        loan,
        payment_id,
        paid_amount,
        paid_interest,
        end_date,
        days_late,
        RANK() over (partition by id order by acquisition_timestamp desc, insert_timestamp desc) as rnk

    from source

),

final as (
    select
        id as installment_id,
        loan as loan_id,
        payment_id,
        paid_amount as amount,
        paid_interest as interest,
        end_date + coalesce(days_late, 0) as payment_date

    from ranked
    where rnk = 1
)

select * from final
    
