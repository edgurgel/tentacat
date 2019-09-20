defmodule Tentacat.Git.BlobsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Git.Blobs

  doctest Tentacat.Git.Blobs

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start()
  end

  test "create/3" do
    use_cassette "git/blob#create" do
      body = %{
        "content" => "Woop!",
        "encoding" => "utf-8"
      }

      {201, %{"sha" => sha}, _} = create(@client, "soudqwiggle", "elixir-conspiracy", body)
      assert sha == "d69a46d50f10c479a19bd56a066c55671180ceec"
    end
  end

  test "get/4" do
    use_cassette "git/blob#get" do
      sha = "d69a46d50f10c479a19bd56a066c55671180ceec"
      {200, res, _} = get(@client, "soudqwiggle", "elixir-conspiracy", sha)
      assert res |> Map.get("sha") == sha
    end
  end
end
