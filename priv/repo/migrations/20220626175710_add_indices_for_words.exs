defmodule WordleBackend.Repo.Migrations.AddIndicesForWords do
  use Ecto.Migration

  def change do
    create index(:words, [:downcased])
  end
end
