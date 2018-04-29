defmodule Tentacat.Organizations.HooksTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Organizations.Hooks

  doctest Tentacat.Organizations.Hooks

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start()
  end

  test "list/2" do
    use_cassette "organizations/hooks#list" do
      assert elem(list(@client, "tentatest"), 1) == []
    end
  end

  test "find/3" do
    use_cassette "organizations/hooks#find" do
      {status_code, _, _} = find(@client, "tentatest", "1234")
      assert status_code == 404
    end
  end

  test "create/3" do
    use_cassette "organizations/hooks#create" do
      body = %{
        "name" => "web",
        "active" => true,
        "events" => ["push", "pull_request"],
        "config" => %{
          "url" => "http://example.com/webhook",
          "content_type" => "json"
        }
      }

      {status_code, _, _} = create(@client, "tentatest", body)
      assert status_code == 201
    end
  end

  test "update/4" do
    body = %{
      "active" => false,
      "add_events" => ["issue"]
    }

    use_cassette "organizations/hooks#update" do
      {_, %{"active" => active}, _} = update(@client, "tentatest", 6_736_758, body)
      assert active == false
    end
  end

  test "ping/3" do
    use_cassette "organizations/hooks#ping" do
      {status_code, _, _} = ping(@client, "tentatest", 6_736_758)
      assert status_code == 204
    end
  end

  test "remove/3" do
    use_cassette "organizations/hooks#remove" do
      {status_code, _, _} = remove(@client, "tentatest", 6_736_758)
      assert status_code == 204
    end
  end
end
