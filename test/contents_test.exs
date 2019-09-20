defmodule Tentacat.ContentsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Contents

  doctest Tentacat.Contents

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start()
  end

  test "readme/4" do
    use_cassette "contents#readme" do
      {_, %{"sha" => sha}, _} = readme(@client, "elixir-lang", "elixir")
      assert sha == "e68b3cab6e531154d4fdfe981605d2a437468528"
    end
  end

  test "find/4" do
    use_cassette "contents#find" do
      {_, [%{"sha" => sha}], _} = find(@client, "elixir-lang", "elixir", "lib")
      assert sha == "c928b5d4c7fa3c0c665cb2d2f591def3bdf29c38"
    end
  end

  test "find_in/5" do
    use_cassette "contents#find_in" do
      {_, [%{"sha" => sha}], _} = find_in(@client, "elixir-lang", "elixir", "lib", "master")
      assert sha == "c928b5d4c7fa3c0c665cb2d2f591def3bdf29c38"
    end
  end

  test "create/5" do
    body = %{
      "message" => "Initial commit",
      "committer" => %{
        "name" => "Soud Qwiggle",
        "email" => "soud@qwiggle.com"
      },
      "content" => Base.encode64("# Yoop!"),
      "branch" => "master"
    }

    use_cassette "contents#create" do
      {status_code, _, _} = create(@client, "soudqwiggle", "elixir-conspiracy", "README.md", body)
      assert status_code == 201
    end
  end

  test "update/5" do
    body = %{
      "message" => "commit after the initial commit",
      "committer" => %{
        "name" => "Soud Qwiggle",
        "email" => "soud@qwiggle.com"
      },
      "content" => Base.encode64("## Woop!"),
      "sha" => "f6147c986f215f640f86f4e337748e3a311bf281",
      "branch" => "master"
    }

    use_cassette "contents#update" do
      {_, %{"commit" => %{"sha" => sha}}, _} =
        update(@client, "soudqwiggle", "elixir-conspiracy", "README.md", body)

      assert sha == "bf7c4ab53fe7503b82b9654d5979ebe8c24ea009"
    end
  end

  test "remove/5" do
    body = %{
      "message" => "remove readme",
      "committer" => %{
        "name" => "Soud Qwiggle",
        "email" => "soud@qwiggle.com"
      },
      "sha" => "c2fb5f1db1767d8f1435952f640ac8e385612482",
      "branch" => "master"
    }

    use_cassette "contents#remove" do
      {_, %{"commit" => %{"sha" => sha}}, _} =
        remove(@client, "soudqwiggle", "elixir-conspiracy", "README.md", body)

      assert sha == "2ff6f7942773c268dc9ab0e11e9dffad402c1860"
    end
  end
end
