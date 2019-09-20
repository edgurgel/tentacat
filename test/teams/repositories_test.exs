defmodule Tentacat.Teams.RepositoriesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Teams.Repositories

  doctest Tentacat.Teams.Repositories

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start()
  end

  test "list/2" do
    use_cassette "teams/repositories#list" do
      assert elem(list(@client, 1_500_000), 1) == []
    end
  end

  test "add/4" do
    use_cassette "teams/repositories#add" do
      assert elem(add(@client, 1_500_000, "valiot", "tentacat"), 1) == nil
    end
  end
end
