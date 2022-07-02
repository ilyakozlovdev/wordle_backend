defmodule WordleBackendWeb.Api.V1.WordsController do
  use WordleBackendWeb, :controller
  import Ecto.Query
  @moduledoc false

  @doc """
    Returnes random word.id sequence
  """
  def index(conn, _) do
    query =
      from word in WordleBackend.Models.Word.__schema__(:source),
        select: word.id,
        order_by: fragment("RANDOM()"),
        limit: 999

    json(
      conn,
      WordleBackend.Repo.all(query)
      |> Enum.shuffle()
    )
  end

  def show(conn, %{"id" => id}) do
    word = WordleBackend.Repo.get!(WordleBackend.Models.Word, id)
    json(conn, word)
  end
end
