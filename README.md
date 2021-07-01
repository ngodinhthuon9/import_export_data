# Ex1
## Installation, Configure & Run
- To install deps: mix deps.get

- To compile: mix compile

- To connect Postgres database:
  username: postgres, password: postgres

- To create repo & migrate database:
  + mix ecto.create
  + mix ecto.mirgrate

- To reset & make change database:
  + mix ecto.drop
  + mix ecto.create
  + mix ecto.mirgrate

- To show status of migrations: mix ecto.migrations

- To run test: mix test

- To run: iex -S mix
  + Import: iex> Ex1.import_product_excel_to_database()
  + Export: iex> Ex1.export_product_database_to_csv()

