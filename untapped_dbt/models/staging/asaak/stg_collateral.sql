with

source as (

    select * from {{ source('asaak', 'collateral') }}

),

ranked as (

    select
        id,
        collateral_name,
        loan,
        RANK() over (partition by id order by acquisition_timestamp desc, insert_timestamp desc) as rnk

    from source

),

final as (

    select
        id as asset_id,
        1 as company_id,
        collateral_name as asset_name,
        loan as loan_id

    from ranked
    where rnk = 1

)

select * from final
    
