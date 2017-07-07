# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :crm,
  ecto_repos: [Crm.Repo]

# Configures the endpoint
config :crm, Crm.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "lxi8+1DLZjGyfW7Y3O1ZK1F9QLsJWz0MqzpmerRhnstMLHcmP7kHJD5eePiMGSPg",
  render_errors: [view: Crm.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Crm.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :arc,
  storage: Arc.Storage.Local

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
