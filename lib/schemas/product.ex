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
    |> validate_required([:sku])
    |> validate_required([:name])
    |> validate_required([:original_price])
    |> validate_required([:price])
    |> validate_required([:status])
    |> validate_number(:original_price, greater_than_or_equal_to: 0)
    |> validate_number(:price, greater_than_or_equal_to: 0)
    |> validate_number(:num, greater_than_or_equal_to: 0)

  end

  def add_new_product(params, row_idx) do
    changeset = Ex1.Product.changeset(%Ex1.Product {}, params)
    cond do
      changeset.valid? -> Ex1.Repo.insert(changeset)
      true -> (
        IO.puts "At row " <> Integer.to_string(row_idx)
        IO.puts changeset.errors
      )
    end
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
