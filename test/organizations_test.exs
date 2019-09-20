defmodule Tentacat.OrganizationsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Organizations

  doctest Tentacat.Organizations

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start()
  end

  test "list/2" do
    use_cassette "organizations#list" do
      assert elem(list(@client, "soudqwiggle"), 1) == []
    end
  end

  test "list_mine/1" do
    use_cassette "organizations#list_mine" do
      {_, [%{"login" => name}], _} = list_mine(@client)
      assert name == "tentatest"
    end
  end

  test "find/2" do
    use_cassette "organizations#find" do
      {_, %{"id" => id}, _} = find(@client, "elixir-conspiracy")
      assert id == 5_861_005
    end
  end

  test "update/3" do
    use_cassette "organizations#update" do
      {_, %{"location" => location}, _} = update(@client, "tentatest", location: "Vecpiebalga")
      assert location == "Vecpiebalga"
    end
  end
end
