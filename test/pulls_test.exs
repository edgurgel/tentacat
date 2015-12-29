defmodule Tentacat.PullsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Pulls

  doctest Tentacat.Pulls

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start
  end

  test "list/3" do
    use_cassette "pulls#list" do
      assert list("tentatest", "tentacat", @client) == []
    end
  end

  test "filter/4" do
    use_cassette "pulls#filter" do
      assert filter("tentatest", "tentacat", %{state: "closed"}, @client) == []
    end
  end

  test "find/4" do
    use_cassette "pulls#find" do
      {status_code, _} = find("tentatest", "tentacat", "1", @client)
      assert status_code == 404
    end
  end

  test "create/4" do
    use_cassette "pulls#create" do
      body = %{
        "title" => "Amazing new Readme",
        "body" => "Every project needs a README",
        "head" => "duksis:master",
        "base" => "master"
      }
      {status_code, _} = create("soudqwiggle", "elixir-conspiracy", body, @client)
      assert status_code == 201
    end
  end

  test "update/5" do
    use_cassette "pulls#update" do
      body = %{
        "state" => "closed"
      }
      %{"title" => title} = update("soudqwiggle", "elixir-conspiracy", "1", body, @client)
      assert title == "Amazing new Readme"
    end
  end
end
