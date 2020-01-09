defmodule SenseWeb.SiteControllerTest do
  use SenseWeb.ConnCase

  alias Sense.Dashboard
  alias Sense.Users.User

  @create_attrs %{name: "name"}
  @update_attrs %{name: "test"}
  @invalid_attrs %{name: nil}

  def fixture(:site) do
    {:ok, site} = Dashboard.create_site(@create_attrs)
    site
  end

  describe "index" do
    setup [:authenticate]

    test "lists all sites", %{conn: conn} do
      conn = get(conn, Routes.site_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Sites"
    end
  end

  describe "new site" do
    setup [:authenticate]

    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.site_path(conn, :new))
      assert html_response(conn, 200) =~ "New Site"
    end
  end

  describe "create site" do
    setup [:authenticate]

    test "redirects to show when data is valid", %{conn: conn} do
      post_conn = post(conn, Routes.site_path(conn, :create), site: @create_attrs)
      assert %{id: id} = redirected_params(post_conn)
      assert redirected_to(post_conn) == Routes.site_path(conn, :show, id)

      get_conn = get(conn, Routes.site_path(conn, :show, id))
      assert html_response(get_conn, 200) =~ "Show Site"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.site_path(conn, :create), site: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Site"
    end
  end

  describe "edit site" do
    setup [:authenticate, :create_site]

    test "renders form for editing chosen site", %{conn: conn, site: site} do
      conn = get(conn, Routes.site_path(conn, :edit, site))
      assert html_response(conn, 200) =~ "Edit Site"
    end
  end

  describe "update site" do
    setup [:authenticate, :create_site]

    test "redirects when data is valid", %{conn: conn, site: site} do
      put_conn = put(conn, Routes.site_path(conn, :update, site), site: @update_attrs)
      assert redirected_to(put_conn) == Routes.site_path(conn, :show, site)

      get_conn = get(conn, Routes.site_path(conn, :show, site))
      assert html_response(get_conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, site: site} do
      conn = put(conn, Routes.site_path(conn, :update, site), site: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Site"
    end
  end

  describe "delete site" do
    setup [:authenticate, :create_site]

    test "deletes chosen site", %{conn: conn, site: site} do
      delete_conn = delete(conn, Routes.site_path(conn, :delete, site))
      assert redirected_to(delete_conn) == Routes.site_path(delete_conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.site_path(conn, :show, site))
      end
    end
  end

  defp create_site(_) do
    site = fixture(:site)
    {:ok, site: site}
  end

  defp authenticate(%{conn: conn}) do
    user = %User{email: "test@example.com"}
    conn = Pow.Plug.assign_current_user(conn, user, otp_app: :sensenew)

    {:ok, conn: conn}
  end
end
