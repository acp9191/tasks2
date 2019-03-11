# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tasks2,
  ecto_repos: [Tasks2.Repo]

# Configures the endpoint
config :tasks2, Tasks2Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "MtpTh7KncYN1B41pZRtifEu0edfSXsKY1jumAuv9v97NvMJlKHAVh5xnSTkf2bTQ",
  render_errors: [view: Tasks2Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tasks2.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
