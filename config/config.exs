# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :headless_blog,
  ecto_repos: [HeadlessBlog.Repo]

# Configures the endpoint
config :headless_blog, HeadlessBlogWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: System.get_env("SECRET_KEY_BASE"),
  render_errors: [view: HeadlessBlogWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: HeadlessBlog.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: System.get_env("LIVE_SALT")
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix,
  json_library: Jason,
  template_engines: [leex: Phoenix.LiveView.Engine]

config :headless_blog, :pow,
  user: HeadlessBlog.Accounts.Users.User,
  repo: HeadlessBlog.Repo,
  web_module: HeadlessBlogWeb,
  extensions: [PowResetPassword],
  controller_callbacks: Pow.Extension.Phoenix.ControllerCallbacks

config :phoenix_inline_svg, dir: "/priv/icons/"
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
