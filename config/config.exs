# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :wwelo_test,
  ecto_repos: [WweloTest.Repo]

# Configures the endpoint
config :wwelo_test, WweloTestWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "i/AveSFMBgAKODXzNBHbm5RukCUnGEiYY8c2a7rYr69N/mMJKbYoipG7aunMImMU",
  render_errors: [view: WweloTestWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: WweloTest.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
