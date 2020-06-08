defmodule Tentacat.Pulls.ReviewsTests do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Pulls.Reviews

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start()
  end

  test "list/4" do
    use_cassette "pulls/reviews#list" do
      assert elem(list(@client, "tentatest", "tentacat", 1), 1) == []
    end
  end

  test "create/5" do
    body = %{
      "body" => "Forgot this change.",
      "comments" => [
        %{
          "body" => "Another change needed",
          "path" => "file-1.md",
          "position" => 3
        }
      ],
      "commit_id" => "5cc70fd733536e3b443bf43d3ba45e49efa77ae8",
      "event" => "COMMENT"
    }

    use_cassette "pulls/reviews#create", match_requests_on: [:request_body] do
      {status_code, _, _} =
        create(@client, "sreecodeslayer", "to-test-github-app-events", "1", body)

      assert status_code == 200
    end
  end
end
