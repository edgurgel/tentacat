defmodule Tentacat.UsersTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Users

  doctest Tentacat.Users

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start
  end

  test "find/2" do
    use_cassette "users#find" do
      %{"name" => name} = find("duksis", @client)
      assert name == "Hugo Duksis"
    end
  end

  test "me/1" do
    use_cassette "users#me" do
      %{"login" => login} = me(@client)
      assert login == "soudqwiggle"
    end
  end

  test "list/1" do
    use_cassette "users#list", match_requests_on: [:query] do
      assert list(@client) == []
    end
  end

  test "list_since/2" do
    use_cassette "users#list_since", match_requests_on: [:query] do
      assert list_since(348, @client) == []
    end
  end

  test "update/2" do
    use_cassette "users#update" do
      %{"hireable" => hireable} = update([hireable: true], @client)
      assert hireable == true
    end
  end
end
