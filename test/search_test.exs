
defmodule Tentacat.SearchTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Search

  doctest Tentacat.Search

  @client Tentacat.Client.new

  setup_all do
    HTTPoison.start
  end

  test "code/2" do
    use_cassette "search#code" do
      params = %{q: "code language:elixir repo:edgurgel/tentacat", sort: "url"}
      assert %{"incomplete_results" => false, "items" => _} = code(params, @client)
    end
  end
end
