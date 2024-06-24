defmodule Tentacat.Issues.ReactionsTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Issues.Reactions

  doctest Tentacat.Issues.Reactions

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start()
  end

  test "list/4" do
    use_cassette "issues/reactions#list" do
      assert {200, _, _} = list(@client, "soudqwiggle", "elixir-conspiracy", "1")
    end
  end

  test "create/5" do
    body = %{
      "content" => ":+1:"
    }

    use_cassette "issues/reactions#create" do
      assert {201, _, _} = create(@client, "soudqwiggle", "elixir-conspiracy", "1", body)
    end
  end

  test "delete/5" do
    use_cassette "issues/reactions#delete" do
      assert {204, _, _} = delete(@client, "dwyl", "learn-elixir", "1", "2")
    end
  end
end
