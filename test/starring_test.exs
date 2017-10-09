defmodule Tentacat.Users.StarringTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Users.Starring

  doctest Tentacat.Users.Starring

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start
  end

  test "starred?/3" do
    use_cassette "starring#starred_/1" do
      assert starred?("elixir-lang", "elixir", @client) == true
    end

    use_cassette "starring#starred_/2" do
      assert starred?("edgurgel", "tentacat", @client) == false
    end
  end

  test "star/3" do
    use_cassette "starring#star" do
      assert star("elixir-lang", "elixir", @client) == true
    end
  end

  test "unstar/3" do
    use_cassette "starring#unstar" do
      assert unstar("elixir-lang", "elixir", @client) == true
    end
  end
end
