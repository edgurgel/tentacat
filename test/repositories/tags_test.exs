defmodule Tentacat.Repositories.TagsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Repositories.Tags

  doctest Tentacat.Repositories.Tags

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start
  end

  test "list/3" do
    use_cassette "repositories/tags#list" do
      assert list("soudqwiggle", "elixir-conspiracy", @client) == []
    end
  end
end

