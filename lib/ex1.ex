
defmodule Ex1 do
  @moduledoc """
  Documentation for `Ex1`.
  Provide function import_product_excel_to_database/0 to import products in excel file to our database postgres
  Provide function extract_all_fields_of_row/2 support to extract fields of a row in excel file using Xlsxir dependence
  Provide function export_product_database_to_csv/0 to get imported data from database postgres and write to .csv file
  """

  @input_excel_file_name  "product.xlsx" # our input file excel .xlsx file name
  @output_csv_file_name "product.csv" # our output file .csv file name

  @doc """
  Hello world.

  ## Examples

      iex> Ex1.hello()
      :world

  """
  def hello do
    :world
  end


  @doc """
  Import products in excel file to our database postgres
  ## Parameters
  No

  ## Examples

      iex> Ex1.import_product_excel_to_database()

  """
  def import_product_excel_to_database do
    Ex1.Product.remove_all_product()
    {:ok, table_id} = Xlsxir.multi_extract(@input_excel_file_name, 0)
    info = Xlsxir.get_info(table_id)
    {:rows, num_rows} = Enum.at(info, 0)
    Enum.each(1..num_rows, fn(row_idx) ->
      {sku, name, provider, brand, original_price, price, num, status} = extract_all_fields_of_row(table_id, row_idx)
      Ex1.Product.add_new_product(%{sku: sku, name: name, provider: provider, brand: brand, original_price: original_price, price: price, num: num, status: status})
    end)
  end

  @doc """
  Support to extract fields of a row in excel file using Xlsxir dependence
  ## Parameters
    - table_id: The id of table that represents the excel data.

    - row_idx: The id of row in the table of excel data.


  ## Examples

      iex> Ex1.extract_all_fields_of_row(Xlsxir.multi_extract("product.xlsx", 0) |> elem(1), 1)

  """
  def extract_all_fields_of_row(table_id, row_idx) do
    row = Xlsxir.get_row(table_id, row_idx)
    sku = Enum.at(row, 0)
    name = Enum.at(row, 2)
    provider = Enum.at(row, 3)
    brand = Enum.at(row, 4)
    original_price = Enum.at(row, 5)
    price = Enum.at(row, 6)
    num = Enum.at(row, 8)
    status_str = Enum.at(row, 9)
    status = if (status_str == "Còn hàng"), do: 2, else: if (status_str == "Sắp hết") , do: 1, else: 0
    {sku, name, provider, brand, original_price, price, num, status}
  end


  @doc """
    Get imported data from database postgres and write to .csv file
    ## Parameters
      No


    ## Examples
        iex> Ex1.export_product_database_to_csv()

  """
  def export_product_database_to_csv do
    File.rm_rf(@output_csv_file_name)
    filewriter = File.open(@output_csv_file_name, [:append]) |> elem(1)
    data = "SKU,Tên sản phẩm,Nhà cung cấp,Thương hiệu,Giá gốc,Đơn giá,Số lượng,Trạng thái\n"
    IO.binwrite(filewriter, data)
    all_product = Ex1.Product.query_all_product()
    cond do
      length(all_product) == 0 -> {:error, "No data"}
      length(all_product) > 0 -> {:ok,
        Enum.each(0..length(all_product)-1, fn(row_idx) ->
          %{sku: sku, name: name, provider: provider, brand: brand, original_price: original_price, price: price, num: num, status: status} = Enum.at(all_product, row_idx)
          status_str = if (status == 2), do: "Còn hàng", else: if (status == 1), do: "Sắp hết", else: "Hết hàng"
          data = sku <> "," <> name <> "," <> provider <> "," <> brand <> "," <> Integer.to_string(original_price) <> "," <> Integer.to_string(price)
          <> "," <> Integer.to_string(num) <> "," <> status_str <> "\n"
          IO.binwrite(filewriter, data)
        end)
      }
    end
  end

end
