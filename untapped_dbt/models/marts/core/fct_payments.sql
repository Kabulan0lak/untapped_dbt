with

asaak_payments as (

    select * from {{ ref('int_asaak_payment_by_asset') }}

),

final as (

    select * from asaak_payments
    -- union
    -- select ...

)

select * from final