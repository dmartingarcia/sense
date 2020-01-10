defmodule SenseWeb.Features.IndexPageTest do
  use SenseWeb.FeatureCase, async: true
  import Wallaby.Query

  test "index page has a welcome message", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css("#sign-in"))
    |> assert_has(css("a", text: "Register"))
  end
end
