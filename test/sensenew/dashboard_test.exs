defmodule Sense.DashboardTest do
  use Sense.DataCase

  alias Sense.Dashboard

  describe "sites" do
    alias Sense.Dashboard.Site

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def site_fixture(attrs \\ %{}) do
      {:ok, site} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Dashboard.create_site()

      site
    end

    test "list_sites/0 returns all sites" do
      site = site_fixture()
      assert Dashboard.list_sites() == [site]
    end

    test "get_site!/1 returns the site with given id" do
      site = site_fixture()
      assert Dashboard.get_site!(site.id) == site
    end

    test "create_site/1 with valid data creates a site" do
      assert {:ok, %Site{} = site} = Dashboard.create_site(@valid_attrs)
    end

    test "create_site/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create_site(@invalid_attrs)
    end

    test "update_site/2 with valid data updates the site" do
      site = site_fixture()
      assert {:ok, %Site{} = site} = Dashboard.update_site(site, @update_attrs)
    end

    test "update_site/2 with invalid data returns error changeset" do
      site = site_fixture()
      assert {:error, %Ecto.Changeset{}} = Dashboard.update_site(site, @invalid_attrs)
      assert site == Dashboard.get_site!(site.id)
    end

    test "delete_site/1 deletes the site" do
      site = site_fixture()
      assert {:ok, %Site{}} = Dashboard.delete_site(site)
      assert_raise Ecto.NoResultsError, fn -> Dashboard.get_site!(site.id) end
    end

    test "change_site/1 returns a site changeset" do
      site = site_fixture()
      assert %Ecto.Changeset{} = Dashboard.change_site(site)
    end
  end
end
