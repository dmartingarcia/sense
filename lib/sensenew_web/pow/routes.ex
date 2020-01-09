defmodule SenseWeb.Pow.Routes do
  use Pow.Phoenix.Routes
  alias SenseWeb.Router.Helpers, as: Routes

  @moduledoc """
  Pow custom user flows
  """

  def after_sign_in_path(conn), do: Routes.dashboard_path(conn, :index)
  def after_register_path(conn), do: Routes.pow_session_path(conn, :new)
  def after_sign_out_path(conn), do: Routes.page_path(conn, :index)
  def user_not_authenticated_path(conn), do: Routes.pow_session_path(conn, :new)
  def user_authenticated_path(conn), do: Routes.dashboard_path(conn, :index)
end
