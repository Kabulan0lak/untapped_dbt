with

source as (
    select * from {{ source('flexclub', 'revenue') }}
)

select * from source