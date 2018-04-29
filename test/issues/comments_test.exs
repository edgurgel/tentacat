defmodule Tentacat.Issues.CommentsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Issues.Comments

  doctest Tentacat.Issues.Comments

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start()
  end

  test "list/4" do
    use_cassette "issues/comments#list" do
      assert elem(list(@client, "soudqwiggle", "elixir-conspiracy", "1"), 1) == []
    end
  end

  test "list_all/3" do
    use_cassette "issues/comments#list_all" do
      assert elem(list_all(@client, "tentatest", "tentacat"), 1) == []
    end
  end

  test "filter/5" do
    use_cassette "issues/comments#filter" do
      {_, res, _} = filter(@client, "elixir-lang", "elixir", 3970, since: "2015-11-16T23:59:59Z")

      [%{"id" => 157_567_508} | _] = res
    end
  end

  test "filter_all/4" do
    use_cassette "issues/comments#filter_all" do
      {_, [], _} =
        filter_all(
          @client,
          "elixir-lang",
          "elixir",
          dir: "desc",
          sort: "created",
          since: "2016-07-01T23:59:59Z"
        )
    end
  end

  test "find/4" do
    use_cassette "issues/comments#find" do
      {_, %{"body" => body}, _} = find(@client, "soudqwiggle", "elixir-conspiracy", 165_902_446)
      assert body == ":100: "
    end
  end

  test "create/5" do
    body = %{"body" => "woop!"}

    use_cassette "issues/comments#create" do
      {status_code, _, _} = create(@client, "soudqwiggle", "elixir-conspiracy", "3", body)
      assert status_code == 201
    end
  end

  test "update/5" do
    body = %{"body" => "up!"}

    use_cassette "issues/comments#update" do
      {_, %{"body" => comment}, _} = update(@client, "lest", "test-repo", 253_744_502, body)
      assert comment == "up!"
    end
  end
end
