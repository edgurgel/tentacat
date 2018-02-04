defmodule Tentacat.Users.StarringTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Users.Starring

  doctest Tentacat.Users.Starring

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})
  @bad_client Tentacat.Client.new(%{access_token: "badtokencomeshere"})

  setup_all do
    HTTPoison.start
  end

  test "starred?/3" do
    use_cassette "starring#starred_/1" do
      assert elem(starred?("elixir-lang", "elixir", @client),1)  == true
    end

    use_cassette "starring#starred_/2" do
      assert elem(starred?("edgurgel", "tentacat", @client),1) == false
    end

    use_cassette "starring#starred_/3" do
      {status_code, _,_} = starred?("elixir-lang", "elixir", @bad_client)
      assert status_code == 401
    end
  end

  test "star/3" do
    use_cassette "starring#star/1" do
       assert {_,true,_} = star("elixir-lang", "elixir", @client)
    end

    use_cassette "starring#star/2" do
      {status_code, _,_} = star("elixir-lang", "elixir", @bad_client)
      assert status_code == 401
    end
  end

  test "unstar/3" do
    use_cassette "starring#unstar/1" do
      assert elem(unstar("elixir-lang", "elixir", @client),1) == true
    end

    use_cassette "starring#unstar/2" do
      {status_code, _,_} = unstar("elixir-lang", "elixir", @bad_client)
      assert status_code == 401
    end
  end
end
