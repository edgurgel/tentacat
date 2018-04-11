defmodule Tentacat.Users.EventsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Users.Events

  doctest Tentacat.Users.Events

  @client Tentacat.Client.new()

  setup_all do
    HTTPoison.start()
  end

  test "list/2" do
    use_cassette "users/events#list" do
      assert elem(list(@client, "soudqwiggle"), 1) == []
    end
  end

  test "list_public/2" do
    use_cassette "users/events#list_public" do
      assert elem(list_public(@client, "soudqwiggle"), 1) == []
    end
  end

  test "list_user_org/3" do
    use_cassette "users/events#list_user_org" do
      assert {404, _, _} = list_user_org(@client, "duksis", "honeypotio")
    end
  end

  test "list_received_public/2" do
    use_cassette "users/events#list_received_public", match_requests_on: [:query] do
      assert elem(list_received_public(@client, "duksis"), 1) == []
    end
  end
end
