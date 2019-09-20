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
end
