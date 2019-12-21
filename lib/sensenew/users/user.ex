defmodule Sense.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  @moduledoc """
   Pow user implementation
  """

  schema "users" do
    pow_user_fields()

    timestamps()
  end
end
