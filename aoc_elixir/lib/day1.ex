defmodule Day1 do
  def calculate_two(collection) do
    sum_check = 2020

    first_factor = collection
      |> Enum.with_index
      |> Enum.find(fn({element, index}) ->
        subcollection = collection |> Enum.slice(index + 1, Enum.count(collection))

        element < sum_check && Enum.find(subcollection, fn second_element -> second_element == sum_check - element end)
      end)
      |> elem(0)
    second_factor = collection |> Enum.find(fn element -> element == sum_check - first_factor end)

    first_factor * second_factor
  end
end
