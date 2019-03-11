use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tasks2, Tasks2Web.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :tasks2, Tasks2.Repo,
  username: "tasks2",
  password: "base12ball",
  database: "tasks2_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
