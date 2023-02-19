with

borrowers as (

    select * from {{ ref('stg_borrowers') }}

),

final as (

    select * from borrowers
    -- union
    -- select * from emprego_users
    -- union
    -- select * from flexclub_users

)

select * from final