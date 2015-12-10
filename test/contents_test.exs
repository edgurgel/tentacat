defmodule Tentacat.ContentsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Contents

  doctest Tentacat.Contents

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start
  end

  test "find/4" do
    use_cassette "contents#find" do
      [%{"sha" => sha}] = find("elixir-lang", "elixir", "lib", @client)
      assert sha == "c928b5d4c7fa3c0c665cb2d2f591def3bdf29c38"
    end
  end

  test "find_in/5" do
    use_cassette "contents#find_in" do
      [%{"sha" => sha}] = find_in("elixir-lang", "elixir", "lib", "master", @client)
      assert sha == "c928b5d4c7fa3c0c665cb2d2f591def3bdf29c38"
    end
  end

  test "create/5" do
    body = %{
      "message" => "Initial commit",
      "committer" => %{
        "name" => "Soud Qwiggle",
        "email"=> "soud@qwiggle.com"
      },
      "content" => Base.encode64("# Yoop!"),
      "branch"=> "master"
    }
    use_cassette "contents#create" do
      {status_code, _} = create("soudqwiggle", "elixir-conspiracy", "README.md", body, @client)
      assert status_code == 201
    end
  end

  test "update/5" do
    body = %{
      "message" => "commit after the initial commit",
      "committer" => %{
        "name" => "Soud Qwiggle",
        "email"=> "soud@qwiggle.com"
      },
      "content" => Base.encode64("## Woop!"),
      "sha" => "f6147c986f215f640f86f4e337748e3a311bf281",
      "branch"=> "master"
    }
    use_cassette "contents#update" do
      %{"commit" => %{"sha" => sha}} = update("soudqwiggle", "elixir-conspiracy", "README.md", body, @client)
      assert sha == "bf7c4ab53fe7503b82b9654d5979ebe8c24ea009"
    end
  end

  test "remove/5" do
    body = %{
      "message" => "remove readme",
      "committer" => %{
        "name" => "Soud Qwiggle",
        "email"=> "soud@qwiggle.com"
      },
      "sha" => "c2fb5f1db1767d8f1435952f640ac8e385612482",
      "branch"=> "master"
    }
    use_cassette "contents#remove" do
      %{"commit"=>%{"sha"=>sha}} = remove("soudqwiggle", "elixir-conspiracy", "README.md", body, @client)
      assert sha == "2ff6f7942773c268dc9ab0e11e9dffad402c1860"
    end
  end

end
