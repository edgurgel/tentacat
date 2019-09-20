defmodule Tentacat.UsersTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Users

  doctest Tentacat.Users

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start()
  end

  test "find/2" do
    use_cassette "users#find" do
      {_, %{"name" => name}, _} = find(@client, "duksis")
      assert name == "Hugo Duksis"
    end
  end

  test "me/1" do
    use_cassette "users#me" do
      {_, %{"login" => login}, _} = me(@client)
      assert login == "soudqwiggle"
    end
  end

  test "list/1" do
    use_cassette "users#list", match_requests_on: [:query] do
      assert elem(list(@client), 1) == []
    end
  end

  test "list_since/2" do
    use_cassette "users#list_since", match_requests_on: [:query] do
      assert elem(list_since(@client, 348), 1) == []
    end
  end

  test "update/2" do
    use_cassette "users#update" do
      {_, %{"hireable" => hireable}, _} = update(@client, hireable: true)
      assert hireable == true
    end
  end
end
