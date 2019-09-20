defmodule Tentacat.SearchTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Search

  doctest Tentacat.Search

  @client Tentacat.Client.new()

  setup_all do
    HTTPoison.start()
  end

  test "code/2" do
    use_cassette "search#code" do
      params = %{q: "code language:elixir repo:edgurgel/tentacat", sort: "url"}
      assert {_, %{"incomplete_results" => false, "items" => _}, _} = code(@client, params)
    end
  end

  test "code/2 with none-pagination" do
    use_cassette "search#code" do
      params = %{q: "code language:elixir repo:edgurgel/tentacat", sort: "url", per_page: 1}

      assert {_, %{"incomplete_results" => false, "items" => _}, _} =
               code(@client, params, pagination: :none)
    end
  end

  test "users/2" do
    use_cassette "search#users" do
      params = %{q: "elixir-lang language:elixir", sort: "followers"}
      assert {_, %{"incomplete_results" => false, "items" => _}, _} = users(@client, params)
    end
  end

  test "users/2 with none-pagination" do
    use_cassette "search#users" do
      params = %{q: "elixir-lang language:elixir", sort: "followers", per_page: 1}

      assert {_, %{"incomplete_results" => false, "items" => _}, _} =
               users(@client, params, pagination: :none)
    end
  end

  test "repositories/2" do
    use_cassette "search#repositories" do
      params = %{q: "elixir-lang in:name language:elixir", sort: "stars"}

      assert {_, %{"incomplete_results" => false, "items" => _}, _} =
               repositories(@client, params)
    end
  end

  test "repositories/2 with none-pagination" do
    use_cassette "search#repositories" do
      params = %{q: "elixir-lang in:name language:elixir", sort: "stars", per_page: 1}

      assert {_, %{"incomplete_results" => false, "items" => _}, _} =
               repositories(@client, params, pagination: :none)
    end
  end

  test "issues/2" do
    use_cassette "search#issues" do
      params = %{q: "repo:edgurgel/tentacat is:merged", sort: "comments"}

      assert {_, %{"incomplete_results" => false, "items" => _}, _} = issues(@client, params)
    end
  end

  test "issues/2 with none-pagination" do
    use_cassette "search#issues" do
      params = %{q: "repo:edgurgel/tentacat is:open", sort: "comments"}

      assert {_, %{"incomplete_results" => false, "items" => _}, _} =
               issues(@client, params, pagination: :none)
    end
  end
end
