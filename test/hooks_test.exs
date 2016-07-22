defmodule Tentacat.HooksTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Hooks

  doctest Tentacat.Hooks

  @client Tentacat.Client.new(%{access_token: "8e663c8614ced27c09b963f806ac46776a29db50"})

  setup_all do
    HTTPoison.start
  end

  test "list/3" do
    use_cassette "hooks#list" do
      assert list("tentatest", "tentacat", @client) == []
    end
  end

  test "find/4" do
    use_cassette "hooks#find" do
      {status_code, _} = find("tentatest", "tentacat", "1234", @client)
      assert status_code == 404
    end
  end

  test "create/4" do
    use_cassette "hooks#create" do
      body = %{
        "name" => "web",
        "active" => true,
        "events" => ["push", "pull_request"],
        "config" => %{
          "url" => "http://example.com/webhook",
          "content_type" => "json"
        }
      }
      {status_code, _} = create("soudqwiggle", "elixir-conspiracy", body, @client)
      assert status_code == 201
    end
  end

  test "update/5" do
    body = %{
      "active" => false,
      "add_events" => ["issue"]
    }
    use_cassette "hooks#update" do
      %{"active" => active} = update("soudqwiggle", "elixir-conspiracy", 6736758, body, @client)
      assert active == false
    end
  end

  test "test/4" do
    use_cassette "hooks#test" do
      {status_code, _} = test("soudqwiggle", "elixir-conspiracy", 6736758, @client)
      assert status_code == 204
    end
  end

  test "ping/4" do
    use_cassette "hooks#ping" do
      {status_code, _} = ping("soudqwiggle", "elixir-conspiracy", 6736758, @client)
      assert status_code == 204
    end
  end

  test "remove/4" do
    use_cassette "hooks#remove" do
      {status_code, _} = remove("soudqwiggle", "elixir-conspiracy", 6736758, @client)
      assert status_code == 204
    end
  end
end
