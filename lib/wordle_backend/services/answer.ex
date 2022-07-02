defmodule WordleBackend.Services.Answer do
  def check_answer(expected, actual) do
    [String.graphemes(expected), String.graphemes(actual)]
    |> Enum.zip()
    |> Enum.map(fn chars -> compare_chars(chars, expected) end)
    |> result()
  end

  defp compare_chars({expected_char, actual_char}, expected) do
    cond do
      expected_char == actual_char -> {:equal, actual_char}
      String.contains?(expected, actual_char) -> {:bad_position, actual_char}
      true -> {:not_present, actual_char}
    end
  end

  defp result(comparison_result) do
    cond do
      Enum.all?(comparison_result, fn {res, _} -> res == :equal end) -> {:passed, nil}
      true -> {:not_passed, comparison_result}
    end
  end
end
