defmodule Tentacat.Repositories.ContributorsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Repositories.Contributors

  doctest Tentacat.Repositories.Contributors

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start()
  end

  test "list/3" do
    use_cassette "repositories/contributors#list" do
      assert elem(list(@client, "antonydenyer", "tentatest"), 1)
             |> Enum.count() == 1
    end
  end
end
