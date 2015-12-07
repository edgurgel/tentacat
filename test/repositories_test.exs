defmodule Tentacat.RepositoriesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Repositories

  doctest Tentacat.Repositories

  @client Tentacat.Client.new(%{access_token: "f3c5a340944a18ad4cdf603c17be8245e71bcf87"})

  setup_all do
    HTTPoison.start
  end

  test "list_mine/1" do
    use_cassette "repositories#list_mine" do
      assert list_mine(@client) == []
    end
  end

  test "list_users/2" do
    use_cassette "repositories#list_users" do
      [%{"name" => name}] = list_users("duksis", @client)
      assert name == "tentacat"
    end
  end

  test "list_orgs/2" do
    use_cassette "repositories#list_orgs" do
      [%{"name" => name}] = list_orgs("elixir-conspiracy", @client)
      assert name == "pacman"
    end
  end

  test "list_public/1" do
    use_cassette "repositories#list_public" do
      assert list_public == []
    end
  end

  test "repo_get/3" do
    use_cassette "repositories#repo_get" do
      %{"name" => name} = repo_get("elixir-conspiracy", "pacman", @client)
      assert name == "pacman"
    end
  end

  test "create/3" do
    use_cassette "repositories#create" do
      {status, _response} = create("tentacat", @client, [private: false])
      assert status == 201
    end
  end

  test "org_create/4" do
    use_cassette "repositories#org_create" do
      {status, _response} = org_create("tentatest", "tentacat", @client, [private: false])
      assert status == 201
    end
  end

  test "delete/3" do
    use_cassette "repositories#delete" do
      {status, _response} = delete("soudqwiggle", "tentacat", @client)
      assert status == 204
    end
  end

end
