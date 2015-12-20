defmodule Tentacat.Commits.CommentsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Commits.Comments

  doctest Tentacat.Commits.Comments

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start
  end

  test "list_all/3" do
    use_cassette "commits/comments#list_all" do
      assert list_all("tentatest", "tentacat", @client) == []
    end
  end

  test "list/4" do
    use_cassette "commits/comments#list" do
      assert list("soudqwiggle", "elixir-conspiracy", "b426f957a26cd4d632da3b174372c973ab083523", @client) == []
    end
  end

  test "find/4" do
    use_cassette "commits/comments#find" do
      %{"body" => body} = find("soudqwiggle", "elixir-conspiracy", 15079374, @client)
      assert body == ":sheep: :lv:"
    end
  end

  test "create/5" do
    body = %{
      "body" => ":sheep: :it:",
      "path" => "README.md",
      "position" => 1
    }
    use_cassette "commits/comments#create" do
      {status_code, _} = create("soudqwiggle", "elixir-conspiracy", "b426f957a26cd4d632da3b174372c973ab083523", body, @client)
      assert status_code == 201
    end
  end

  test "update/5" do
    body = %{
      "body" => ":sheep: :lv:"
    }
    use_cassette "commits/comments#update" do
      %{"id" => commit_id} = update("soudqwiggle", "elixir-conspiracy", 15079374, body, @client)
      assert commit_id == 15079374
    end
  end

  test "delete/4" do
    use_cassette "commits/comments#delete" do
      {status_code, _} = delete("soudqwiggle", "elixir-conspiracy", 15079374, @client)
      assert status_code == 204
    end
  end
end
