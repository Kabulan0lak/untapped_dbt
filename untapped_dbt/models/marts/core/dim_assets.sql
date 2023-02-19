with

asaak_assets as (
    select
        asset_id,
        company_id,
        asset_name
    from
        {{ ref('stg_collateral') }}
),

emprego_assets as (
    select
        null::text as asset_id,
        null::int as company_id,
        null::text as asset_name
    from
        {{ ref('stg_bank_device') }}
    where
        1 = 0
),

flexclub_assets as (
    select
        null::text as asset_id,
        null::int as company_id,
        null::text as asset_name
    from
        {{ ref('stg_vehicles') }}
    where
        1 = 0
),

final as (
    select * from asaak_assets
    union
    select * from emprego_assets
    union
    select * from flexclub_assets
)

select * from final