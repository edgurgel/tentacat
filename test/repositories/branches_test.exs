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
      assert elem(list(@client, "antonydenyer", "tentatest"), 1)
             |> Enum.count() == 1
    end
  end

  test "find/4" do
    use_cassette "repositories/branches#find" do
      assert elem(find(@client, "antonydenyer", "tentatest", "master"), 1)["name"] == "master"
    end
  end

  test "update_protection/5" do
    body = %{
      "required_status_checks" => "null",
      "enforce_admins" => "null",
      "required_pull_request_reviews" => "null",
      "restrictions" => "null"
    }

    use_cassette "repositories/branches#update_protection" do
      assert elem(update_protection(@client, "antonydenyer", "tentatest", "master", body), 1)
             |> Enum.count() == 1
    end
  end
end
