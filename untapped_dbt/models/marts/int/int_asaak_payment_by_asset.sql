with

installments as (

    select * from {{ ref('stg_installments') }} as installments

),

collateral as (

    select * from {{ ref('stg_collateral') }} as collateral

),

nb_collaterals_by_loan as (

    select
        loan_id,
        count(asset_id) as nb_collaterals

    from collateral
    group by 1
),

installment_by_collateral as (

    select
        asset_id,
        payment_date,
        amount / nb_collaterals as amount,
        interest / nb_collaterals as interest
    from
        collateral c
        left join nb_collaterals_by_loan n
            using(loan_id)
        left join installments i
            using(loan_id)

)

select * from installment_by_collateral