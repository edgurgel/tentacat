defmodule Tentacat.RepositoriesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Repositories

  doctest Tentacat.Repositories

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start
  end

  test "list_mine/1" do
    use_cassette "repositories#list_mine" do
      assert elem(list_mine(@client),1) == []
    end
  end

  test "list_users/2" do
    use_cassette "repositories#list_users" do
      {_,[%{"name" => name}],_} = list_users("duksis", @client)
      assert name == "tentacat"
    end
  end

  test "list_users/2 with auto-pagination" do
    use_cassette "repositories#list_user_auto_pagination", match_requests_on: [:query] do
      all_repos = list_users("jeffweiss", @client, [], pagination: :auto)
      assert Enum.count(all_repos) > 130
    end
  end

  test "list_users/2 with streaming pagination" do
    use_cassette "repositories#list_user_streaming_pagination", match_requests_on: [:query] do
      stream = list_users("jeffweiss", @client, [], pagination: :stream)
      assert Enum.count(Enum.take(stream, 31)) == 31
    end
  end

  test "list_users/2 with manual pagination" do
    use_cassette "repositories#list_user_manual_pagination", match_requests_on: [:query] do
      {{_,body,_}, next_link, auth} = list_users("octocat", @client, [], pagination: :manual)
      assert Enum.count(body) == 5
      assert next_link == nil
      assert auth == @client.auth
    end
  end

  test "list_users/2 with parameters" do
    use_cassette "repositories#list_user_with_params", match_requests_on: [:query] do
      {_,repos,_} = list_users("octocat", @client, [sort: :created, direction: :asc])
      names = Enum.map(repos, &Map.get(&1, "name"))
      assert names == ["Hello-World", "Spoon-Knife", "octocat.github.io", "git-consortium", "hello-worId"]
    end

  end

  test "list_orgs/2" do
    use_cassette "repositories#list_orgs" do
      {_,[%{"name" => name}],_} = list_orgs("elixir-conspiracy", @client)
      assert name == "pacman"
    end
  end

  test "list_public/1" do
    use_cassette "repositories#list_public", match_requests_on: [:query] do
      assert {_,[],_} = list_public()
    end
  end

  test "repo_get/3" do
    use_cassette "repositories#repo_get" do
      {_,%{"name" => name},_} = repo_get("elixir-conspiracy", "pacman", @client)
      assert name == "pacman"
    end
  end

  test "create/3" do
    use_cassette "repositories#create" do
      {status, _response,_} = create("tentacat", @client, [private: false])
      assert status == 201
    end
  end

  test "org_create/4" do
    use_cassette "repositories#org_create" do
      {status, _response,_} = org_create("tentatest", "tentacat", @client, [private: false])
      assert status == 201
    end
  end

  test "delete/3" do
    use_cassette "repositories#delete" do
      {status, _response,_} = delete("soudqwiggle", "tentacat", @client)
      assert status == 204
    end
  end

end
