defmodule Tentacat.GistsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Gists

  doctest Tentacat.Gists

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start()
  end

  test "list_mine/2" do
    use_cassette "gists#list_mine" do
      assert length(elem(list_mine(@client), 1)) == 1
    end
  end

  test "list_users/2" do
    use_cassette "gists#list_users" do
      {_, [%{"description" => description}], _} = list_users(@client, "octocat")
      assert description == "Hello World Examples"
    end
  end

  test "list_public/0" do
    use_cassette "gists#list_public", match_requests_on: [:query] do
      {_, [%{"public" => public}], _} = list_public(@client)
      assert public
    end
  end

  test "list_public/0 with parameters" do
    use_cassette "gists#list_public_with_params", match_requests_on: [:query] do
      {_, [%{"public" => public}], _} = list_public(@client, since: "2019-07-04 12:34")
      assert public
    end
  end

  test "list_starred/1" do
    use_cassette "gists#list_starred" do
      assert length(elem(list_starred(@client), 1)) == 1
    end
  end

  test "gist_get/2" do
    use_cassette "gists#gist_get" do
      {status_code, _, _} = gist_get(@client, "fe771b85eeeff878d177b0c0f3840afd")
      assert status_code == 200
    end
  end

  test "get_revision/2" do
    use_cassette "gists#get_revision" do
      gist_id = "fe771b85eeeff878d177b0c0f3840afd"
      revision_sha = "0ba06a873509677ab40b8ed5575f249a55c6fc41"
      {status_code, %{"url" => url}, _} = get_revision(gist_id, revision_sha)
      assert url == "https://api.github.com/gists/#{gist_id}/#{revision_sha}"
      assert status_code == 200
    end
  end

  test "list_forks/2" do
    use_cassette "gists#list_forks" do
      {status, response, _} = list_forks(@client, "0feff8bfe771b85ee0c3840afd78d177")
      assert status == 200
      assert length(response) == 1
    end
  end

  test "delete/2" do
    use_cassette "gists#delete" do
      {status, _response, _} = delete(@client, "0feff8bfe771b85ee0c3840afd78d177")
      assert status == 204
    end
  end
end
