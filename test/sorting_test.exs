defmodule SortingTest do
  use ExUnit.Case
  doctest Sorting
  
  describe "sorting" do
    setup do
      list1 = Sorting.List.new() 
        |>    Sorting.List.add_entry(300, "Bob")
        
      list2 = Sorting.List.new() 
      |>  Sorting.List.add_entry(300, "Bob")
      |>  Sorting.List.add_entry(301, "Kelly")
      
      list3 = Sorting.List.new() 
      |>  Sorting.List.add_entry(300, "Bob")
      |>  Sorting.List.add_entry(301, "Kelly")
      |>  Sorting.List.add_entry(302, "Andrew")
      |>  Sorting.List.add_entry(303, "Andrew")
      |>  Sorting.List.add_entry(305, "Xander")
      
      list4 = Sorting.List.new() 
      |>  Sorting.List.add_entry(300, "Bob")
      |>  Sorting.List.add_entry(301, "Kelly")
      |>  Sorting.List.add_entry(410, "Andrew")
      |>  Sorting.List.add_entry(420, "Andrew")
      |>  Sorting.List.add_entry(430, "Andrew")
      |>  Sorting.List.add_entry(305, "Xander")
      |>  Sorting.List.add_entry(306, "Bob")
        
      %{list1: list1, list2: list2, list3: list3, list4: list4}
    end
    
    test "sorts list with 1 item", context do
      display_list = Sorting.sort(context.list1) 
                  |> Sorting.List.display()
      assert display_list == [300]
    end
    
    test "sorts list with 2 items", context do
      
      display_list = Sorting.sort(context.list2) 
                  |> Sorting.List.display()
      
      assert display_list == [300, 301]
    end
    
    test "sorts complicated list with a batch by requester", context do
      display_list = Sorting.sort(context.list4, :requesters)
                    |> Sorting.List.display()
      assert display_list == [300, 301, 410, 305, 306, 420, 430]
    end
    
    # test "find_batches organized a list into batches", context do
    #   batches = Sorting.find_batches(context.list3)
      
      
    #   assert
    # end
  end
end
