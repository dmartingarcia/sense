defmodule SenseWeb.SiteController do
  use SenseWeb, :controller

  alias Sense.Dashboard
  alias Sense.Dashboard.Site

  def index(conn, _params) do
    sites = Dashboard.list_sites()
    render(conn, "index.html", sites: sites)
  end

  def new(conn, _params) do
    changeset = Dashboard.change_site(%Site{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"site" => site_params}) do
    case Dashboard.create_site(site_params) do
      {:ok, site} ->
        conn
        |> put_flash(:info, "Site created successfully.")
        |> redirect(to: Routes.site_path(conn, :show, site))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    site = Dashboard.get_site!(id)
    render(conn, "show.html", site: site)
  end

  def edit(conn, %{"id" => id}) do
    site = Dashboard.get_site!(id)
    changeset = Dashboard.change_site(site)
    render(conn, "edit.html", site: site, changeset: changeset)
  end

  def update(conn, %{"id" => id, "site" => site_params}) do
    site = Dashboard.get_site!(id)

    case Dashboard.update_site(site, site_params) do
      {:ok, site} ->
        conn
        |> put_flash(:info, "Site updated successfully.")
        |> redirect(to: Routes.site_path(conn, :show, site))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", site: site, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    site = Dashboard.get_site!(id)
    {:ok, _site} = Dashboard.delete_site(site)

    conn
    |> put_flash(:info, "Site deleted successfully.")
    |> redirect(to: Routes.site_path(conn, :index))
  end
end
