defmodule Ex1.Product do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "products" do
    field :sku, :string, null: false
    field :name, :string, null: false
    field :provider, :string
    field :brand, :string
    field :original_price, :integer, null: false
    field :price, :integer, null: false
    field :num, :integer
    field :status, :string, null: false
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:sku, :name, :provider, :brand, :original_price, :price, :num, :status])
  end

  def add_new_product(params) do
    %Ex1.Product {}
    |> Ex1.Product.changeset(params)
    |> Ex1.Repo.insert()
  end

  def query_all_product do
    query = from (Ex1.Product), order_by: [asc: :id]
    Ex1.Repo.all(query)
  end

  def remove_all_product do
    query = from (Ex1.Product)
    Ex1.Repo.delete_all(query)
  end

end
