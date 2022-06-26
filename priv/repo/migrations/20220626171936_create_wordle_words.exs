defmodule WordleBackend.Repo.Migrations.CreateWordleWords do
  use Ecto.Migration

  def change do
    create table(:words) do
      add :original, :string
      add :downcased, :string
      add :definition, :text

      timestamps()
    end
  end
end
