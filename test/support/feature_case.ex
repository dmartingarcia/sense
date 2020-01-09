defmodule SenseWeb.FeatureCase do
  use ExUnit.CaseTemplate

  @moduledoc """
  Feature test helper and config
  """

  using do
    quote do
      use Wallaby.DSL

      alias Sense.Repo
      import Ecto
      import Ecto.Changeset
      import Ecto.Query

      import SenseWeb.Router.Helpers
    end
  end

  setup tags do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Sense.Repo)

    unless tags[:async] do
      Ecto.Adapters.SQL.Sandbox.mode(Sense.Repo, {:shared, self()})
    end

    metadata = Phoenix.Ecto.SQL.Sandbox.metadata_for(Sense.Repo, self())
    {:ok, session} = Wallaby.start_session(metadata: metadata)
    {:ok, session: session}
  end
end
