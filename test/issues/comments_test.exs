defmodule Tentacat.Issues.CommentsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Issues.Comments

  doctest Tentacat.Issues.Comments

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start
  end

  test "list/4" do
    use_cassette "issues/comments#list" do
      assert list("soudqwiggle", "elixir-conspiracy", "1", @client) == []
    end
  end

  test "list_all/3" do
    use_cassette "issues/comments#list_all" do
      assert list_all("tentatest", "tentacat", @client) == []
    end
  end

  test "find/4" do
    use_cassette "issues/comments#find" do
      %{"body" => body} = find("soudqwiggle", "elixir-conspiracy", 165902446, @client)
      assert body == ":100: "
    end
  end

  test "create/5" do
    body = %{ "body" => "woop!" }
    use_cassette "issues/comments#create" do
      {status_code, _} = create("soudqwiggle", "elixir-conspiracy", "3", body, @client)
      assert status_code == 201
    end
  end
end
