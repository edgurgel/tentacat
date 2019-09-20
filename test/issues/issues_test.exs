defmodule Tentacat.IssuesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Issues

  doctest Tentacat.Issues

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start()
  end

  test "list/3" do
    use_cassette "issues/issues#list" do
      assert elem(list(@client, "soudqwiggle", "elixir-conspiracy"), 1) == []
    end
  end

  test "filter/4" do
    use_cassette "issues/issues#filter" do
      assert elem(filter(@client, "soudqwiggle", "elixir-conspiracy", %{"state" => "open"}), 1) ==
               []
    end
  end

  test "find/4" do
    use_cassette "issues/issues#find" do
      {_, %{"body" => body}, _} = find(@client, "soudqwiggle", "elixir-conspiracy", 1347)
      assert body == "Something is broken"
    end
  end

  test "create/4" do
    body = %{
      "title" => "Something broke"
    }

    use_cassette "issues/issues#create" do
      {status_code, %{"title" => title}, _} =
        create(@client, "soudqwiggle", "elixir-conspiracy", body)

      assert status_code == 201
      assert title == "Something broke"
    end
  end

  test "update/5" do
    body = %{
      "state" => "closed"
    }

    use_cassette "issues/issues#update" do
      {_, %{"state" => state}, _} = update(@client, "soudqwiggle", "elixir-conspiracy", "3", body)
      assert state == "closed"
    end
  end
end
