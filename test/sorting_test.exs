defmodule SortingTest do
  use ExUnit.Case
  doctest Sorting
  
  describe "sorting" do
    setup do
      list1 = Sorting.List.new() 
        |>    Sorting.List.add_entry(300, "Bob")
        
      list2 = Sorting.List.new() 
      |>    Sorting.List.add_entry(300, "Bob")
      |>    Sorting.List.add_entry(301, "Bobby")
        
      %{list1: list1, list2: list2}
    end
    
    test "sorts list with 1 item", context do
      display_list = Sorting.sort(context.list1) 
                  |> Sorting.List.display()
      assert display_list == [300]
    end
    
    test "sorts list with 2 items", context do
      IO.puts("original_list: ")
      IO.inspect(context.list2)
      
      display_list = Sorting.sort(context.list2) 
                  |> Sorting.List.display()
      IO.puts("display_list: ")
      IO.inspect(display_list)
      
      assert display_list == [300, 301]
    end
  end
end
