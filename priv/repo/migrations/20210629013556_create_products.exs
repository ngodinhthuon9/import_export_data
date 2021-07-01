defmodule Ex1.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :sku, :string, null: false
      add :name, :string, null: false
      add :provider, :string
      add :brand, :string
      add :original_price, :integer, null: false
      add :price, :integer, null: false
      add :num, :integer
      add :status, :string, null: false
    end
  end

end
