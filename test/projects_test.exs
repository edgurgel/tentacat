defmodule Tentacat.ProjectsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Projects

  doctest Tentacat.Projects

  @client Tentacat.Client.new(%{access_token: "36ca77c021b72b826f7279c479b555c897181e7b"})

  setup_all do
    # We need this to access this endpoint as its part of the developer preview
    Application.put_env(:tentacat, :extra_headers, [
      {"Accept", "application/vnd.github.inertia-preview+json"}
    ])

    ExVCR.Config.filter_request_headers("Authorization")
    HTTPoison.start()
  end

  test "find/2" do
    use_cassette "projects#find" do
      {_, %{"id" => id}, _} = find(@client, 2539313)
      assert id == 2539313
    end
  end

  test "update/3" do
    use_cassette "projects#update" do
      {_, %{"name" => name}, _} = update(@client, 2539313, name: "New Demo")
      assert name == "New Demo"
    end
  end
end
