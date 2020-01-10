defmodule SenseWeb.Features.UserLoginFlowTest do
  use SenseWeb.FeatureCase, async: true
  import Wallaby.Query

  alias Sense.Users.User
  alias Sense.Repo

  @email "test@example.org"
  @password "12341234"

  test "a user is able to register, sign-in and sign-out", %{session: session} do

    session
    |> visit("/")
    |> click(link("Register"))
    |> fill_in(text_field("Email"), with: @email)
    |> fill_in(text_field("Password"), with: @password)
    |> fill_in(text_field("Confirm password"), with: @password)
    |> click(button("Register"))

    assert Repo.aggregate(User, :count, :id)  == 1

    session
    |> assert_has(link("Sign out"))
    |> click(link("Sign out"))
    |> assert_has(link("Sign in"))
    |> click(link("Sign in"))
    |> fill_in(text_field("Email"), with: @email)
    |> fill_in(text_field("Password"), with: @password)
    |> click(button("Sign in"))
    |> assert_has(css("a", text: "Sign out"))
  end
end
