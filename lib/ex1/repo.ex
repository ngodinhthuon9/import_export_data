defmodule Ex1.Repo do
  use Ecto.Repo,
    otp_app: :ex1,
    adapter: Ecto.Adapters.Postgres
end
