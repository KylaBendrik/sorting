defmodule Sorting.List do
  def new() do
    []
  end
  
  def add_entry(list, number, requester) do
    new_entry = Sorting.Entry.new(number, requester)
    
    [new_entry | list]
  end
  
  def display(list) do
    display_list = Enum.map(list, fn entry -> entry.number end)
    IO.inspect(display_list)
  end
end
