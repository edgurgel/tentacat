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

  test "list/3" do
    use_cassette "users/events#list_e_tag" do
      assert {304, _, _} =
               list(
                 @client,
                 "soudqwiggle",
                 "1e1eaa79cefda6e152f880f49c5bd0c6a4bf662c957cdfe7c2923d316c4db966"
               )
    end
  end

  test "list_public/2" do
    use_cassette "users/events#list_public" do
      assert elem(list_public(@client, "soudqwiggle"), 1) == []
    end
  end

  test "list_public/3" do
    use_cassette "users/events#list_public_e_tag" do
      assert {304, _, _} =
               list_public(
                 @client,
                 "soudqwiggle",
                 "1e1eaa79cefda6e152f880f49c5bd0c6a4bf662c957cdfe7c2923d316c4db966"
               )
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
