defmodule Tentacat.Repositories.ProjectsTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Repositories.Projects

  doctest Tentacat.Projects

  @client Tentacat.Client.new(%{access_token: "c43203ed664cc6165e6cffc370e44cbeaa34774c"})

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

  test "create/4" do
    use_cassette "repositories/projects#create", match_requests_on: [:request_body] do
      {status, _response, _} =
        create(@client, "achiurizo", "dotfiles", %{name: "tentacat", body: "my new project"})

      assert status == 201
    end
  end
end
