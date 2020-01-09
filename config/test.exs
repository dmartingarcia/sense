use Mix.Config

# Configure your database
database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :sensenew, Sense.Repo,
  url: database_url,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sensenew, SenseWeb.Endpoint,
  http: [port: 4002],
  server: true

config :sensenew, :sql_sandbox, true

# Print only warnings and errors during test
config :logger, level: :warn

config :wallaby,
  driver: Wallaby.Experimental.Chrome,
  chrome: [headless: true],
  screenshot_on_failure: true,
  screenshot_dir: System.get_env("WALLABY_SCREENSHOT_DIR") || "screenshots"
