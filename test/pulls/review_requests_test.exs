defmodule Tentacat.Pulls.ReviewRequestsTests do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Pulls.ReviewRequests

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start()
  end

  test "list/4" do
    use_cassette "pulls/review_requests#list" do
      assert elem(list(@client, "tentatest", "tentacat", 1), 1) == []
    end
  end

  test "create/5" do
    reviewers = ["tentacat"]

    use_cassette "pulls/review_requests#create" do
      {status_code, body, _} = create(@client, "tentatest", "tentacat", 1, reviewers)
      assert status_code == 201
      assert is_map(body)
    end
  end

  test "delete/5" do
    reviewers = ["tentacat"]

    use_cassette "pulls/review_requests#remove" do
      {_, res, _} = remove(@client, "tentatest", "tentacat", 1, reviewers)
      assert is_map(res)
    end
  end
end
