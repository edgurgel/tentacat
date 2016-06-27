defmodule Tentacat.Issues.CommentsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Issues.Comments

  doctest Tentacat.Issues.Comments

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start
  end

  test "list/4" do
    use_cassette "issues/comments#list" do
      assert list("soudqwiggle", "elixir-conspiracy", "1", @client) == []
    end
  end

  test "list_all/3" do
    use_cassette "issues/comments#list_all" do
      assert list_all("tentatest", "tentacat", @client) == []
    end
  end

  test "filter/5" do
    use_cassette "issues/comments#filter" do
      [%{"id" => 157567508} | _] = filter("elixir-lang", "elixir", 3970, [since: "2015-11-16T23:59:59Z"], @client)
    end
  end

  test "filter_all/4" do
    use_cassette "issues/comments#filter_all" do
      [] = filter_all("elixir-lang", "elixir", [dir: "desc", sort: "created", since: "2016-07-01T23:59:59Z"], @client)
    end
  end

  test "find/4" do
    use_cassette "issues/comments#find" do
      %{"body" => body} = find("soudqwiggle", "elixir-conspiracy", 165902446, @client)
      assert body == ":100: "
    end
  end

  test "create/5" do
    body = %{ "body" => "woop!" }
    use_cassette "issues/comments#create" do
      {status_code, _} = create("soudqwiggle", "elixir-conspiracy", "3", body, @client)
      assert status_code == 201
    end
  end
end
