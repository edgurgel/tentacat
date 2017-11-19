defmodule Tentacat.Issues.Comments.ReactionsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Issues.Comments.Reactions

  doctest Tentacat.Issues.Comments.Reactions

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start
  end

  test "list/4" do
    use_cassette "issues/comments/reactions#list" do
      assert list("soudqwiggle", "elixir-conspiracy", "1", @client) == []
    end
  end

  test "create/5" do
    body = %{
      "content" => ":+1:",
    }
    use_cassette "issues/comments/reactions#create" do
      {status_code, _} = create("soudqwiggle", "elixir-conspiracy", "1", body, @client)
      assert status_code == 201
    end
  end
end
