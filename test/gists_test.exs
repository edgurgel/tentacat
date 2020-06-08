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
      assert description == "Hello world!"
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
      gist_id = "aa5a315d61ae9438b18d"
      revision_sha = "57a7f021a713b1c5a6a199b54cc514735d2d462f"
      {status_code, %{"url" => url}, _} = get_revision(gist_id, revision_sha)
      assert url == "https://api.github.com/gists/#{gist_id}/#{revision_sha}"
      assert status_code == 200
    end
  end

  test "create/2" do
    use_cassette "gists#create", match_requests_on: [:request_body] do
      body = %{
        "files" => %{
          "hello.rb" => %{"content" => "puts 'Hello World'"},
          "hello.py" => %{"content" => "print 'Hello World'"}
        },
        "description" => "Hello World Examples",
        "public" => false
      }

      {status, _, _} = create(@client, body)
      assert status == 201
    end
  end

  test "edit/3" do
    use_cassette "gists#edit", match_requests_on: [:request_body] do
      body = %{
        "description" => "Hello World Examples",
        "files" => %{
          "hello_world_ruby.txt" => %{
            "content" => "Run `ruby hello.rb` or `python hello.py` to print Hello World",
            "filename" => "hello.md"
          },
          "hello_world_python.txt" => nil,
          "new_file.txt" => %{
            "content" => "This is a new placeholder file."
          }
        }
      }

      {status, _, _} = edit(@client, "0feff8bfe771b85ee0c3840afd78d177", body)
      assert status == 200
    end
  end

  test "list_forks/2" do
    use_cassette "gists#list_forks" do
      {status, response, _} = list_forks(@client, "0feff8bfe771b85ee0c3840afd78d177")
      assert status == 200
      assert length(response) == 1
    end
  end

  test "fork/2" do
    use_cassette "gists#fork" do
      {status, _, _} = fork(@client, "0feff8bfe771b85ee0c3840afd78d177")
      assert status == 201
    end
  end

  test "star/2" do
    use_cassette "gists#star" do
      {status, _, _} = star(@client, "0feff8bfe771b85ee0c3840afd78d177")
      assert status == 204
    end
  end

  test "unstar/2" do
    use_cassette "gists#unstar" do
      {status, _, _} = unstar(@client, "0feff8bfe771b85ee0c3840afd78d177")
      assert status == 204
    end
  end

  test "check_if_starred/2 with starred" do
    use_cassette "gists#check_if_starred" do
      {status, _, _} = check_if_starred(@client, "0feff8bfe771b85ee0c3840afd78d177")
      assert status == 204
    end
  end

  test "check_if_starred/2 with not starred" do
    use_cassette "gists#check_if_starred_not_starred" do
      {status, _, _} = check_if_starred(@client, "0feff8bfe771b85ee0c3840afd78d177")
      assert status == 404
    end
  end

  test "list_commits#2" do
    use_cassette "gists#list_commits" do
      {status, response, _} = list_commits(@client, "0feff8bfe771b85ee0c3840afd78d177")
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
