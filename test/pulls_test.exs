defmodule Tentacat.PullsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Pulls

  doctest Tentacat.Pulls

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start()
  end

  test "list/3" do
    use_cassette "pulls#list" do
      assert elem(list(@client, "tentatest", "tentacat"), 1) == []
    end
  end

  test "filter/4" do
    use_cassette "pulls#filter" do
      assert elem(filter(@client, "tentatest", "tentacat", %{state: "closed"}), 1) == []
    end
  end

  test "find/4" do
    use_cassette "pulls#find" do
      {status_code, _, _} = find(@client, "tentatest", "tentacat", "1")
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

      {status_code, _, _} = create(@client, "soudqwiggle", "elixir-conspiracy", body)
      assert status_code == 201
    end
  end

  test "update/5" do
    use_cassette "pulls#update" do
      body = %{
        "state" => "closed"
      }

      {_, %{"title" => title}, _} = update(@client, "soudqwiggle", "elixir-conspiracy", "1", body)
      assert title == "Amazing new Readme"
    end
  end

  test "merge/5" do
    use_cassette "pulls#merge" do
      body = %{
        commit_message: "not the default commit_message"
      }

      {_, %{"merged" => merged}, _} = merge(@client, "sdost", "elixir-conspiracy", "1", body)
      assert merged == true
    end
  end

  test "has_been_merged/4" do
    use_cassette "pulls#has_been_merged" do
      {status_code, _, _} = has_been_merged(@client, "sdost", "elixir-conspiracy", "1")
      assert status_code == 204
    end
  end
end
