defmodule Sorting do
  @moduledoc """
  Documentation for `Sorting`.
  
  Sorts primarily by timestamp.
  """

  def sort(list) do
    sort(list, :timestamp)
  end
  
  def sort(list, :timestamp) do
    # sorts only by the :datetime key
    list |> Enum.sort(fn entry1, entry2 -> (DateTime.compare(entry1.datetime, entry2.datetime) == :gt) end)
  end
  
  def sort(list, :requesters) do
    # sorts only by the :datetime key
    time_sorted_list = sort(list, :timestamp)
    
    # check for repeated requesters. If there is a request after a duplicate, push this one off until later
    # organize into batches, which are groups of requests by a single requester
    batches = find_batches(time_sorted_list, [])
    |> Enum.map(fn batch -> Sorting.sort(batch) end)
    
    # reconstruct a single list from these batches. 
    # Go through each batch and pull out the first to add to the final list. If the batch is empty, great! all done with that.
    # If there's more in that batch, go through and pull out the next one.
    
    Enum.reverse(make_new_list(batches, []))
  end
  
  defp make_new_list([first_batch | []], list) do
    #if there are no more batches, just add this whole batch onto the request list and return
    Enum.reverse(first_batch) ++ list
  end
  
  defp make_new_list([[only_request | []] | other_batches], list) do
    #if there are no other requests in this batch, put the one request on the front of the request list, and pass the rest of the batches on.
    make_new_list(other_batches, [only_request | list])  
  end
  
  defp make_new_list([[first_request | other_requests] | other_batches], list) do
    # if there are other requests in this batch, put them on the end of the batch list. Put the first request on the front of the request list.
    make_new_list(other_batches ++ [other_requests], [first_request | list])
  end
  
  
  # returns a list of lists, each on being the group of requests by a single requester
  defp find_batches([first | rest], []) do
    # There are no batches found yet
    find_batches([first | rest], [[first]])
  end
  
  defp find_batches([first, second | []], batches) do
    # No more requests after these two. Time to quit
    cond do
      first.requester == second.requester ->
        [most_recent_batch | other_batches] = batches
        Enum.reverse([[second | most_recent_batch] | other_batches])
      true -> 
        Enum.reverse([[second] | batches])
    end 
  end
  
  defp find_batches([first, second | rest], batches) do
    # basic loop. Check if the first and second have the same requester. 
    # If so, add the second one to the same batch as the first. (which will always be the most recent)
    cond do
      first.requester == second.requester ->
        [most_recent_batch | other_batches] = batches
        find_batches([second | rest], [[second | most_recent_batch] | other_batches])
      true -> 
        find_batches([second | rest], [[second] | batches])
    end 
  end
  
end
