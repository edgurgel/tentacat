defmodule Tentacat.App.InstallationsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.App.Installations

  doctest Tentacat.App.Installations

  @client Tentacat.Client.new(%{jwt: "your.jwt.here"})

  setup_all do
    Application.put_env(:tentacat, :extra_headers, [
      {"Accept", "application/vnd.github.machine-man-preview+json"}
    ])

    ExVCR.Config.filter_request_headers("Authorization")
    HTTPoison.start()
  end

  test "list_mine/1" do
    use_cassette "app/installations#list_mine" do
      assert length(elem(list_mine(@client), 1)) == 1
    end
  end

  test "find/2" do
    use_cassette "app/installations#find" do
      assert elem(find(@client, 66216), 1)["id"] == 66216
    end
  end

  test "token/2" do
    use_cassette "app/installations#token" do
      assert elem(token(@client, 66216), 1)["token"] ==
               "v1.b328f705dbba381a0f61697986a8faa09dacb097"
    end
  end

  test "list_repositories/1" do
    use_cassette "app/installations#list_repositories" do
      token = elem(token(@client, 66216), 1)["token"]
      client = Tentacat.Client.new(%{access_token: token})
      {_, %{"repositories" => repositories}, _} = list_repositories(client)
      assert length(repositories) == 2
    end
  end
end
