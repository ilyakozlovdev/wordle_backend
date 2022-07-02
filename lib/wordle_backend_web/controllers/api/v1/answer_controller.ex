defmodule WordleBackendWeb.Api.V1.AnswerController do
  use WordleBackendWeb, :controller
  @moduledoc false

  def answer(conn, %{"word_id" => id, "answer" => answer}) do
    with {:ok, actual} <- get_word_by_value(answer),
         {:ok, expected} <- get_word_by_id(id) do
      result = WordleBackend.Services.Answer.check_answer(expected.downcased, actual.downcased)
      json(conn, result)
    else
      {:error, err_msg} -> json(conn, %{"error_message" => err_msg})
    end
  end

  defp get_word_by_value(value) do
    case WordleBackend.Repo.get_by(WordleBackend.Models.Word, downcased: String.downcase(value)) do
      nil -> {:error, "В словаре нет такого слова"}
      word -> {:ok, word}
    end
  end

  defp get_word_by_id(id) do
    case WordleBackend.Repo.get(WordleBackend.Models.Word, id) do
      nil -> {:error, "Слово с этим ID не найдено"}
      word -> {:ok, word}
    end
  end
end
