defmodule Tentacat.ReactionsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Reactions

  doctest Tentacat.Releases

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start
  end

  test "delete/4" do
    use_cassette "reactions#delete" do
      {status_code, _,_} = delete(2317708, "soudqwiggle", "elixir-conspiracy", @client)
      assert status_code == 204
    end
  end
end
