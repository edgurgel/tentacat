defmodule Tentacat.Repositories.ForksTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Repositories.Forks

  doctest Tentacat.Repositories.Forks

  @client Tentacat.Client.new(%{access_token: "yourtokenhere"})

  setup_all do
    HTTPoison.start()
  end

  test "list/3" do
    use_cassette "repositories/forks#list" do
      assert elem(list(@client, "shanewilton", "tentacat"), 1) == []

      assert elem(list(@client, "nwoodthorpe", "core-contributor-scratchpad"), 1) |> Enum.count() ==
               1
    end
  end

  test "create/4" do
    use_cassette "repositories/forks#create" do
      {status_code, %{"owner" => %{"login" => owner}}, _} =
        create(@client, "ShaneWilton", "tentacat", %{})

      assert status_code == 202
      assert owner == "ShaneWilton"
    end
  end
end
