defmodule Tentacat.Repositories.LanguagesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Repositories.Languages

  doctest Tentacat.Repositories.Languages

  @client Tentacat.Client.new()

  setup_all do
    HTTPoison.start()
  end

  test "list/3" do
    use_cassette "repositories/languages#list" do
      {_, result, _} = list(@client, "edgurgel", "tentacat")
      assert Map.has_key?(result, "Elixir")
    end
  end
end
