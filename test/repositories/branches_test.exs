defmodule Tentacat.Repositories.BranchesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  import Tentacat.Repositories.Branches

  doctest Tentacat.Repositories.Branches

  @client Tentacat.Client.new(%{access_token: "yourtokencomeshere"})

  setup_all do
    HTTPoison.start()
  end

  test "list/3" do
    use_cassette "repositories/branches#list" do
      assert elem(list(@client, "valiot", "tentacat"), 1)
             |> Enum.count() >= 1
    end
  end

  test "find/4" do
    use_cassette "repositories/branches#find" do
      assert elem(find(@client, "valiot", "tentacat", "master"), 1)["name"] == "master"
    end
  end

  test "update_protection/5" do
    body = %{
      "required_status_checks" => nil,
      "enforce_admins" => nil,
      "required_pull_request_reviews" => nil,
      "restrictions" => nil
    }

    use_cassette "repositories/branches#update_protection" do
      assert elem(update_protection(@client, "valiot", "tentacat", "master", body), 1)["url"] ==
               "https://api.github.com/repos/valiot/tentacat/branches/master/protection"
    end
  end
end
