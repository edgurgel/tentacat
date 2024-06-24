defmodule Tentacat.Users.StarringTest do
  use ExUnit.Case, async: true
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Users.Starring

  doctest Tentacat.Users.Starring

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})
  @bad_client Tentacat.Client.new(%{access_token: "badtokencomeshere"})

  setup_all do
    HTTPoison.start()
  end

  test "stargazers/3" do
    use_cassette "starring#stargazers_success" do
      assert [%{"login" => "login1"}, %{"login" => "login2"}] =
               elem(stargazers(@client, "elixir-lang", "elixir"), 1)
    end

    use_cassette "starring#stargazers_failed" do
      {status_code, _, _} = stargazers(@bad_client, "elixir-lang", "elixir")
      assert status_code == 401
    end
  end

  test "starred?/3" do
    use_cassette "starring#starred_/1" do
      assert elem(starred?(@client, "elixir-lang", "elixir"), 1) == true
    end

    use_cassette "starring#starred_/2" do
      assert elem(starred?(@client, "edgurgel", "tentacat"), 1) == false
    end

    use_cassette "starring#starred_/3" do
      {status_code, _, _} = starred?(@bad_client, "elixir-lang", "elixir")
      assert status_code == 401
    end
  end

  test "star/3" do
    use_cassette "starring#star/1" do
      assert {_, true, _} = star(@client, "elixir-lang", "elixir")
    end

    use_cassette "starring#star/2" do
      {status_code, _, _} = star(@bad_client, "elixir-lang", "elixir")
      assert status_code == 401
    end
  end

  test "unstar/3" do
    use_cassette "starring#unstar/1" do
      assert elem(unstar(@client, "elixir-lang", "elixir"), 1) == true
    end

    use_cassette "starring#unstar/2" do
      {status_code, _, _} = unstar(@bad_client, "elixir-lang", "elixir")
      assert status_code == 401
    end
  end
end
