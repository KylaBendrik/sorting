defmodule Sorting.Entry do
  defstruct datetime: ~U[2020-08-05 14:35:01.009000Z], number: 0, requester: nil
  
  def new(number, requester)do
    {:ok, now} = DateTime.now("Etc/UTC")
    entry = %Sorting.Entry{datetime: now, number: number, requester: requester}
  end
end
