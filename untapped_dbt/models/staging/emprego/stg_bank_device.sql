with

source as (
    select * from {{ source('emprego', 'transactions') }}
)

select * from source