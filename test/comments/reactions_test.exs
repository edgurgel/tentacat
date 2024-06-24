defmodule Tentacat.Comments.ReactionsTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Comments.Reactions

  doctest Tentacat.Comments.Reactions

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start()
  end

  test "list/4" do
    use_cassette "comments/reactions#list" do
      assert {200, [], _} = list(@client, "soudqwiggle", "elixir-conspiracy", "1")
    end
  end

  test "create/5" do
    body = %{
      "content" => "heart"
    }

    use_cassette "comments/reactions#create", match_requests_on: [:request_body] do
      {status_code, _, _} = create(@client, "soudqwiggle", "elixir-conspiracy", "1", body)
      assert status_code == 201
    end
  end
end
