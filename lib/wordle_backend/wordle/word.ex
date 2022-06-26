defmodule WordleBackend.Word do
  use Ecto.Schema
  import Ecto.Changeset

  schema "words" do
    field :original, :string
    field :downcased, :string
    field :definition, :string

    timestamps()
  end

  @doc false
  def changeset(word, attrs) do
    word
    |> cast(attrs, [:value, :original, :downcased])
    |> validate_required([:value, :original, :downcased])
  end
end
