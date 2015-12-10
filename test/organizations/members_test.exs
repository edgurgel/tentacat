defmodule Tentacat.Organizations.MembersTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Organizations.Members

  doctest Tentacat.Organizations.Members

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start
  end

  test "list/2" do
    use_cassette "members#list" do
      [%{"login" => login}] = list("elixir-conspiracy", @client)
      assert login == "josephwilk"
    end
  end

  test "member?/3" do
    use_cassette "members#member?" do
      assert member?("elixir-conspiracy", "josephwilk", @client) == {302, nil}
    end
  end
end
