with

source as (

    select * from {{ source('asaak', 'loans') }}

),

ranked as (

    select
        id,
        borrower,
        loan_type,
        status,
        amount,
        interest_rate,
        start_date,
        RANK() over (partition by id order by acquisition_timestamp desc, insert_timestamp desc) as rnk

    from source

),

final as (
    
    select
        id as loan_id,
        borrower as user_id,
        loan_type,
        status as loan_status,
        amount,
        interest_rate,
        start_date
        
    from ranked
    where rnk = 1

)

select * from final
    
