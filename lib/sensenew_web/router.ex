defmodule SenseWeb.Router do
  use SenseWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authenticated do
    plug Pow.Plug.RequireAuthenticated, error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :not_authenticated do
    plug Pow.Plug.RequireNotAuthenticated, error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", SenseWeb do
    pipe_through :browser
    pipe_through :not_authenticated

    get "/", PageController, :index
  end

  scope "/", SenseWeb do
    pipe_through :browser
    pipe_through :authenticated

    get "/dashboard", SiteController, :index, as: :dashboard
    resources "/sites", SiteController
  end
end
