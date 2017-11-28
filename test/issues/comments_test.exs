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
      assert elem(list("soudqwiggle", "elixir-conspiracy", "1", @client),1) == []
    end
  end

  test "list_all/3" do
    use_cassette "issues/comments#list_all" do
      assert elem(list_all("tentatest", "tentacat", @client),1) == []
    end
  end

  test "filter/5" do
    use_cassette "issues/comments#filter" do
      {_,res,_} = filter("elixir-lang", "elixir", 3970, [since: "2015-11-16T23:59:59Z"], @client)
      [%{"id" => 157567508} | _] = res
    end
  end

  test "filter_all/4" do
    use_cassette "issues/comments#filter_all" do
      {_,[],_} = filter_all("elixir-lang", "elixir", [dir: "desc", sort: "created", since: "2016-07-01T23:59:59Z"], @client)
    end
  end

  test "find/4" do
    use_cassette "issues/comments#find" do
      {_,%{"body" => body},_} = find("soudqwiggle", "elixir-conspiracy", 165902446, @client)
      assert body == ":100: "
    end
  end

  test "create/5" do
    body = %{ "body" => "woop!" }
    use_cassette "issues/comments#create" do
      {status_code, _,_} = create("soudqwiggle", "elixir-conspiracy", "3", body, @client)
      assert status_code == 201
    end
  end

  test "update/5" do
    body = %{"body" => "up!"}
    use_cassette "issues/comments#update" do
      {_,%{"body" => comment},_} = update("lest", "test-repo", 253744502, body, @client)
      assert comment == "up!"
    end
  end
end
