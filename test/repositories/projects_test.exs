defmodule Tentacat.Repositories.ProjectsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Repositories.Projects

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

  test "list/3" do
    use_cassette "repositories/projects#list" do
      assert elem(list(@client, "achiurizo", "dotfiles"), 1)
             |> Enum.count() >= 1
    end
  end
end
