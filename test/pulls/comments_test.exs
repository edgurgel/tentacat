defmodule Tentacat.Pulls.CommentsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Pulls.Comments

  doctest Tentacat.Pulls.Comments

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start
  end

  test "list_all/3" do
    use_cassette "pulls/comments#list_all" do
      assert list_all("tentatest", "tentacat", @client) == []
    end
  end

  test "list/4" do
    use_cassette "pulls/comments#list" do
      assert list("soudqwiggle", "elixir-conspiracy", "1", @client) == []
    end
  end

  test "filter_all/4" do
    use_cassette "pulls/comments#filter_all" do
      [] = filter_all("elixir-lang", "elixir", [dir: "desc", sort: "created", since: "2016-07-01T23:59:59Z"], @client)
    end
  end

  test "find/4" do
    use_cassette "pulls/comments#find" do
      %{"body" => body} = find("soudqwiggle", "elixir-conspiracy", 47450612, @client)
      assert body == ":100: "
    end
  end

  test "create/5" do
    body = %{
      "body" => ":+1:",
      "commit_id" => "b426f957a26cd4d632da3b174372c973ab083523",
      "path" => "README.md",
      "position" => 1
    }
    use_cassette "pulls/comments#create" do
      {status_code, _} = create("soudqwiggle", "elixir-conspiracy", "1", body, @client)
      assert status_code == 201
    end
  end

  test "update/5" do
    body = %{
      "body" => ":+1:"
    }
    use_cassette "pulls/comments#update" do
      %{"id" => commit_id} = update("soudqwiggle", "elixir-conspiracy", 47450612, body, @client)
      assert commit_id == 47450612
    end
  end

  test "remove/4" do
    use_cassette "pulls/comments#remove" do
      {status_code, _} = remove("soudqwiggle", "elixir-conspiracy", 47450612, @client)
      assert status_code == 204
    end
  end
end
