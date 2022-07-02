import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :wordle_backend, WordleBackend.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "wordle_backend_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :wordle_backend, WordleBackendWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "5Sn3Z09oVVU3k/2mazUcMcRNUnrQQd0Md2g/2kvg8F0qhHdN2FX1zFIzphwRe+0o",
  server: false

config :wordle_backend, WordleBackend.Services.Words, filename: "./test/fixtures/words.json"

# In test we don't send emails.
config :wordle_backend, WordleBackend.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
