defmodule Tentacat.IssuesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Issues

  doctest Tentacat.Issues

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start
  end

  test "list/3" do
    use_cassette "issues/issues#list" do
      assert elem(list("soudqwiggle", "elixir-conspiracy", @client),1) == []
    end
  end

  test "filter/4" do
    use_cassette "issues/issues#filter" do
      assert elem(filter("soudqwiggle", "elixir-conspiracy", %{"state" => "open"}, @client),1) == []
    end
  end

  test "find/4" do
    use_cassette "issues/issues#find" do
      {_,%{"body" => body},_} = find("soudqwiggle", "elixir-conspiracy", 1347, @client)
      assert body == "Something is broken"
    end
  end

  test "create/4" do
    body = %{
      "title" => "Something broke"
    }
    use_cassette "issues/issues#create" do
      {status_code, %{"title" => title},_} = create("soudqwiggle", "elixir-conspiracy", body, @client)
      assert status_code == 201
      assert title == "Something broke"
    end
  end

  test "update/5" do
    body = %{
      "state" => "closed"
    }
    use_cassette "issues/issues#update" do
      {_,%{"state" => state},_} = update("soudqwiggle", "elixir-conspiracy", "3", body, @client)
      assert state == "closed"
    end
  end
end
