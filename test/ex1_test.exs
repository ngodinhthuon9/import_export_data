defmodule Ex1Test do
  use ExUnit.Case
  doctest Ex1

  test "greets the world" do
    assert Ex1.hello() == :world
  end

  @input_excel_file_name  "product.xlsx"
  test "test sku's order matching" do
    Ex1.import_product_excel_to_database()
    {:ok, table_id} = Xlsxir.multi_extract(@input_excel_file_name, 0)
    all_product = Ex1.Product.query_all_product()
    Enum.each(0..length(all_product)-1, fn(row_idx) ->
      assert Map.fetch(Enum.at(all_product, row_idx), :sku) |> elem(1) == Ex1.extract_all_fields_of_row(table_id, row_idx + 2) |> elem(0)
    end)
    Ex1.Product.remove_all_product()
  end

  test "test name matching" do
    Ex1.import_product_excel_to_database()
    {:ok, table_id} = Xlsxir.multi_extract(@input_excel_file_name, 0)
    all_product = Ex1.Product.query_all_product()
    Enum.each(0..length(all_product)-1, fn(row_idx) ->
      if Map.fetch(Enum.at(all_product, row_idx), :sku) |> elem(1) == Ex1.extract_all_fields_of_row(table_id, row_idx + 2) |> elem(0) do
        assert Map.fetch(Enum.at(all_product, row_idx), :name) |> elem(1) == Ex1.extract_all_fields_of_row(table_id, row_idx + 2) |> elem(1)
      end
    end)
    Ex1.Product.remove_all_product()
  end

  test "test provider matching" do
    Ex1.import_product_excel_to_database()
    {:ok, table_id} = Xlsxir.multi_extract(@input_excel_file_name, 0)
    all_product = Ex1.Product.query_all_product()
    Enum.each(0..length(all_product)-1, fn(row_idx) ->
      if Map.fetch(Enum.at(all_product, row_idx), :sku) |> elem(1) == Ex1.extract_all_fields_of_row(table_id, row_idx + 2) |> elem(0) do
        assert Map.fetch(Enum.at(all_product, row_idx), :provider) |> elem(1) == Ex1.extract_all_fields_of_row(table_id, row_idx + 2) |> elem(2)
      end
    end)
    Ex1.Product.remove_all_product()
  end

  test "test brand matching" do
    Ex1.import_product_excel_to_database()
    {:ok, table_id} = Xlsxir.multi_extract(@input_excel_file_name, 0)
    all_product = Ex1.Product.query_all_product()
    Enum.each(0..length(all_product)-1, fn(row_idx) ->
      if Map.fetch(Enum.at(all_product, row_idx), :sku) |> elem(1) == Ex1.extract_all_fields_of_row(table_id, row_idx + 2) |> elem(0) do
        assert Map.fetch(Enum.at(all_product, row_idx), :brand) |> elem(1) == Ex1.extract_all_fields_of_row(table_id, row_idx + 2) |> elem(3)
      end
    end)
    Ex1.Product.remove_all_product()
  end

  test "test original price matching" do
    Ex1.import_product_excel_to_database()
    {:ok, table_id} = Xlsxir.multi_extract(@input_excel_file_name, 0)
    all_product = Ex1.Product.query_all_product()
    Enum.each(0..length(all_product)-1, fn(row_idx) ->
      if Map.fetch(Enum.at(all_product, row_idx), :sku) |> elem(1) == Ex1.extract_all_fields_of_row(table_id, row_idx + 2) |> elem(0) do
        assert Map.fetch(Enum.at(all_product, row_idx), :original_price) |> elem(1) == Ex1.extract_all_fields_of_row(table_id, row_idx + 2) |> elem(4)
      end
    end)
    Ex1.Product.remove_all_product()
  end

  test "test price matching" do
    Ex1.import_product_excel_to_database()
    {:ok, table_id} = Xlsxir.multi_extract(@input_excel_file_name, 0)
    all_product = Ex1.Product.query_all_product()
    Enum.each(0..length(all_product)-1, fn(row_idx) ->
      if Map.fetch(Enum.at(all_product, row_idx), :sku) |> elem(1) == Ex1.extract_all_fields_of_row(table_id, row_idx + 2) |> elem(0) do
        assert Map.fetch(Enum.at(all_product, row_idx), :price) |> elem(1) == Ex1.extract_all_fields_of_row(table_id, row_idx + 2) |> elem(5)
      end
    end)
    Ex1.Product.remove_all_product()
  end

  test "test num matching" do
    Ex1.import_product_excel_to_database()
    {:ok, table_id} = Xlsxir.multi_extract(@input_excel_file_name, 0)
    all_product = Ex1.Product.query_all_product()
    Enum.each(0..length(all_product)-1, fn(row_idx) ->
      if Map.fetch(Enum.at(all_product, row_idx), :sku) |> elem(1) == Ex1.extract_all_fields_of_row(table_id, row_idx + 2) |> elem(0) do
        assert Map.fetch(Enum.at(all_product, row_idx), :num) |> elem(1) == Ex1.extract_all_fields_of_row(table_id, row_idx + 2) |> elem(6)
      end
    end)
    Ex1.Product.remove_all_product()
  end


  test "test status matching" do
    Ex1.import_product_excel_to_database()
    {:ok, table_id} = Xlsxir.multi_extract(@input_excel_file_name, 0)
    all_product = Ex1.Product.query_all_product()
    Enum.each(0..length(all_product)-1, fn(row_idx) ->
      if Map.fetch(Enum.at(all_product, row_idx), :sku) |> elem(1) == Ex1.extract_all_fields_of_row(table_id, row_idx + 2) |> elem(0) do
        assert Map.fetch(Enum.at(all_product, row_idx), :status) |> elem(1) == Ex1.extract_all_fields_of_row(table_id, row_idx + 2) |> elem(7)
      end
    end)
    Ex1.Product.remove_all_product()
  end

  test "test export empty data" do
    Ex1.Product.remove_all_product()
    assert Ex1.export_product_database_to_csv() == {:error, "No data"}
  end

  test "test import valid" do
    assert Ex1.import_product_excel_to_database()==:ok
    Ex1.Product.remove_all_product()
  end

end
