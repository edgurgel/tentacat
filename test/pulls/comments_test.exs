defmodule Tentacat.Pulls.CommentsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Pulls.Comments

  doctest Tentacat.Pulls.Comments

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start()
  end

  test "list_all/3" do
    use_cassette "pulls/comments#list_all" do
      assert elem(list_all(@client, "tentatest", "tentacat"), 1) == []
    end
  end

  test "list/4" do
    use_cassette "pulls/comments#list" do
      assert elem(list(@client, "soudqwiggle", "elixir-conspiracy", "1"), 1) == []
    end
  end

  test "filter_all/4" do
    use_cassette "pulls/comments#filter_all" do
      elem(
        filter_all(
          @client,
          "elixir-lang",
          "elixir",
          dir: "desc",
          sort: "created",
          since: "2016-07-01T23:59:59Z"
        ),
        1
      ) == []
    end
  end

  test "find/4" do
    use_cassette "pulls/comments#find" do
      {_, %{"body" => body}, _} = find(@client, "soudqwiggle", "elixir-conspiracy", 47_450_612)
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
      {status_code, _, _} = create(@client, "soudqwiggle", "elixir-conspiracy", "1", body)
      assert status_code == 201
    end
  end

  test "update/5" do
    body = %{
      "body" => ":+1:"
    }

    use_cassette "pulls/comments#update" do
      {_, %{"id" => commit_id}, _} =
        update(@client, "soudqwiggle", "elixir-conspiracy", 47_450_612, body)

      assert commit_id == 47_450_612
    end
  end

  test "remove/4" do
    use_cassette "pulls/comments#remove" do
      {status_code, _, _} = remove(@client, "soudqwiggle", "elixir-conspiracy", 47_450_612)
      assert status_code == 204
    end
  end
end
