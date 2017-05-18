# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :elm_is_fun,
  ecto_repos: [ElmIsFun.Repo]

# Configures the endpoint
config :elm_is_fun, ElmIsFun.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Nhpe26vE8tK7OQXhdFPgN0JKegqxzvdTjnsX5gS4APrsU2jRB1sUP2SCbQ09j66P",
  render_errors: [view: ElmIsFun.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ElmIsFun.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
