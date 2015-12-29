defmodule Tentacat.OrganizationsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Organizations

  doctest Tentacat.Organizations

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start
  end

  test "list/2" do
    use_cassette "organizations#list" do
      assert list("soudqwiggle", @client) == []
    end
  end

  test "list_mine/1" do
    use_cassette "organizations#list_mine" do
      [%{"login" => name}] = list_mine(@client)
      assert name == "tentatest"
    end
  end

  test "find/2" do
    use_cassette "organizations#find" do
      %{"id" => id} = find("elixir-conspiracy", @client)
      assert id == 5861005
    end
  end

  test "update/3" do
    use_cassette "organizations#update" do
      %{"location" => location} = update("tentatest", [location: "Vecpiebalga"], @client)
      assert location == "Vecpiebalga"
    end
  end
end
