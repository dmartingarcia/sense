defmodule Sense.Repo do
  use Ecto.Repo,
    otp_app: :sensenew,
    adapter: Ecto.Adapters.Postgres
end
