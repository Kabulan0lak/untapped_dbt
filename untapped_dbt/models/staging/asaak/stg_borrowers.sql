with

source as (
    select * from {{ source('asaak', 'borrowers') }}
),

ranked as (
    select
        id,
        borrower_name,
        RANK() over (partition by id order by acquisition_timestamp desc, insert_timestamp desc) as rnk
        
    from source
),

final as (
    select
        id as user_id,
        borrower_name as user_name
        
    from ranked
    where rnk = 1
)

select * from final
    
