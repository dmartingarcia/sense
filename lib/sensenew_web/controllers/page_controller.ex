defmodule SenseWeb.PageController do
  use SenseWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
