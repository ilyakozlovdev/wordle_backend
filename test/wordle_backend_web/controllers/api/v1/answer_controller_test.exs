defmodule WordleBackendWeb.Api.V1.AnswerControllerTest do
  use WordleBackendWeb.ConnCase
  use WordleBackend.DataCase

  setup do
    words = WordleBackend.Services.Words.migrate()
    {:ok, words: words}
  end

  test "POST /api/v1/answer with right answer", %{conn: conn, words: words} do
    word = Enum.at(words, 0)
    conn = post(conn, "/api/v1/answer", %{"word_id" => word.id, "answer" => word.downcased})
    assert json_response(conn, 200) == ["passed", nil]
  end

  test "POST /api/v1/answer with wrong value", %{conn: conn, words: words} do
    word = Enum.at(words, 0)
    conn = post(conn, "/api/v1/answer", %{"word_id" => word.id, "answer" => "ябеда"})
    assert json_response(conn, 200) == ["not_passed", [["not_present", "я"], ["not_present", "б"], ["bad_position", "е"], ["not_present", "д"], ["not_present", "а"]]]
  end
end
