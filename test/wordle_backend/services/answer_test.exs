defmodule WordleBackend.Services.AnswerTest do
  use ExUnit.Case, async: true

  test "should return :passed response on right word" do
    expected = "river"
    actual = "river"
    assert {:passed, nil} = WordleBackend.Services.Answer.check_answer(expected, actual)
  end

  test "should return :not_passed response totally wrong word" do
    expected = "river"
    actual = "build"

    expected_comparison_result = [
      {:not_present, "b"},
      {:not_present, "u"},
      {:bad_position, "i"},
      {:not_present, "l"},
      {:not_present, "d"}
    ]

    assert {:not_passed, ^expected_comparison_result} =
             WordleBackend.Services.Answer.check_answer(expected, actual)
  end

  test "should return right comparison result on some chars right" do
    expected = "river"
    actual = "rivus"

    expected_comparison_result = [
      {:equal, "r"},
      {:equal, "i"},
      {:equal, "v"},
      {:not_present, "u"},
      {:not_present, "s"}
    ]

    assert {:not_passed, ^expected_comparison_result} =
             WordleBackend.Services.Answer.check_answer(expected, actual)
  end
end
