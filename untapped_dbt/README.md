## Untapped technical test: DBT

### Install dbt

DBT runs in a Python environment. First make sure your environment is good to go. Then install DBT for postgres using:
```bash
pip install dbt-postgres
```

### Set up config file

Launch a `dbt init` wherever you want to initiate your setup. Follow the insctruction on prompt, but your choices don't really matter.
A `profiles.yml` file should have been created in this location `~/.dbt/`

Edit it to match your postgres instance credentials:
```yaml
untapped_dbt:
  outputs:
    dev:
      type: postgres
      threads: 4
      host: <host>
      port: <port>
      user: dbt_dev_user
      pass: dbt_dev_user
      dbname: postgres
      schema: dbt_dev
    prod:
      type: postgres
      threads: 4
      host: <host>
      port: <port>
      user: dbt_prod_user
      pass: dbt_prod_user
      dbname: postgres
      schema: dbt_prod
  target: dev
```

### Run it

Position yourself in the `untapped_dbt/untapped_dbt` directory, and run:
```bash
dbt build
```

Every model should run, every test shoud pass except the foreign key on payment_id from installments table that gives 11k unidentified payments.
You can see the newly created tables and views in your dbt_dev_user environment.
