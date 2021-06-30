defmodule Ex1.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :sku, :string, null: false
      add :name, :string
      add :provider, :string
      add :brand, :string
      add :original_price, :integer
      add :price, :integer
      add :num, :integer
      add :status, :integer, default: 1
    end
  end

end
