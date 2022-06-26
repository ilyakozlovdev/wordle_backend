defmodule WordleBackend.Repo do
  use Ecto.Repo,
    otp_app: :wordle_backend,
    adapter: Ecto.Adapters.Postgres
end
