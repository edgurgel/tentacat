defmodule Tentacat.Pulls.Comments.ReactionsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Pulls.Comments.Reactions

  doctest Tentacat.Pulls.Comments.Reactions

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start()
  end

  test "list/4" do
    use_cassette "pulls/comments/reactions#list" do
      assert {200, [], _} = list(@client, "soudqwiggle", "elixir-conspiracy", "1")
    end
  end

  test "create/5" do
    body = %{
      "content" => ":+1:"
    }

    use_cassette "pulls/comments/reactions#create" do
      assert {201, _, _} = create(@client, "soudqwiggle", "elixir-conspiracy", "1", body)
    end
  end
end
